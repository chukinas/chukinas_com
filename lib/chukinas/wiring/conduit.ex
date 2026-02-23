defmodule Chukinas.Wiring.Conduit do
  @moduledoc """
  At a minimum, represents the type of conduit (e.g. EMT).
  May also include the size.
  """

  use TypedStruct
  alias Chukinas.Wiring.NECch9table4, as: Table4
  alias Chukinas.Wiring.WireRun
  alias Chukinas.Wiring.WireSpec

  typedstruct do
    field :type, String.t(), enforce: true
    field :trade_size, String.t()
  end

  defimpl Inspect do
    def inspect(conduit, _opts) do
      maybe_size = if size = conduit.trade_size, do: " #{size}"
      "#Conduit<#{conduit.type}#{maybe_size}>"
    end
  end

  @ch9table4 Table4.read("emt")
             |> Enum.map(fn row ->
               key = {"emt", row.trade_size}
               area = row.total_area_100_percent.in2
               {key, area}
             end)
             |> Map.new()

  @valid_types Map.keys(@ch9table4)
               |> Enum.map(fn {conduit_type, _trade_size} -> conduit_type end)
               |> Enum.uniq()

  # CONSTRUCTORS

  defguardp is_valid(key) when is_map_key(@ch9table4, key)
  defguardp is_valid(type, trade_size) when is_valid({type, trade_size})
  defguard is_valid_type(type) when type in @valid_types

  def new(type) when is_valid_type(type) do
    %__MODULE__{type: type}
  end

  def new(type, trade_size) when is_valid(type, trade_size) do
    %__MODULE__{type: type, trade_size: trade_size}
  end

  def new(type, %WireRun{} = run) do
    init = new(type)

    if size = find_smallest(init, run) do
      new(type, size)
    else
      init
    end
  end

  @valid_expressions Map.keys(@ch9table4)
                     |> Enum.flat_map(fn key ->
                       {type, trade_size} = key

                       [
                         Enum.join([type, trade_size], " "),
                         Enum.join([type, trade_size], ""),
                         Enum.join([trade_size, type], " "),
                         Enum.join([trade_size, type], "")
                       ]
                       |> Enum.map(&{&1, key})
                     end)
                     |> Map.new()
  def parse(type) when is_valid_type(type), do: new(type)

  def parse(line) do
    case @valid_expressions[line] do
      {type, trade_size} -> new(type, trade_size)
      nil -> nil
    end
  end

  # REDUCERS

  def set_size(conduit, size) do
    new(conduit.type, size)
  end

  # CONVERTERS

  defp area(%__MODULE__{} = conduit) do
    Map.fetch!(@ch9table4, key(conduit))
  end

  defp avail_area(conduit, wire_count) when is_integer(wire_count) and wire_count >= 0 do
    area(conduit) * Table4.percent_by_wire_count(wire_count)
  end

  @incr_sizes_by_type @ch9table4
                      |> Enum.sort_by(fn {_key, area} -> area end)
                      |> Enum.map(fn {key, _area} -> key end)
                      |> Enum.group_by(fn {type, _size} -> type end, fn {_type, size} -> size end)

  defp find_smallest(%__MODULE__{type: type, trade_size: nil}, wire) do
    if sized_conduit =
         Map.fetch!(@incr_sizes_by_type, type)
         |> Enum.map(&new(type, &1))
         |> Enum.find(&valid_fill?(&1, wire)) do
      size!(sized_conduit)
    end
  end

  def size!(%__MODULE__{trade_size: trade_size}) when not is_nil(trade_size), do: trade_size

  def has_size?(conduit), do: !!conduit.trade_size

  defp key(%__MODULE__{} = conduit) do
    {conduit.type, conduit.trade_size}
  end

  def max_wire_count(conduit, wire_spec) do
    wire_spec_area = WireSpec.area(wire_spec)
    do_max_wire_count(conduit, wire_spec_area)
  end

  defp do_max_wire_count(conduit, wire_spec_area, count_class \\ 3)
       when is_float(wire_spec_area) and count_class >= 0 do
    avail_area = avail_area(conduit, count_class)
    allowed_count = round_count(avail_area / wire_spec_area)

    allowed_count =
      if count_class < 3 do
        min(allowed_count, count_class)
      else
        allowed_count
      end

    if count_class <= allowed_count do
      allowed_count
    else
      do_max_wire_count(conduit, wire_spec_area, count_class - 1)
    end
  end

  def valid_fill?(conduit, %WireRun{} = wire_run) do
    count = WireRun.count(wire_run)
    wire_area = WireRun.area(wire_run)
    avail_area = avail_area(conduit, count)

    if WireRun.single_spec?(wire_run) do
      wire_spec_area = wire_area / count
      max_wire_count = round_count(avail_area / wire_spec_area)
      max_wire_count >= count
    else
      avail_area >= wire_area
    end
  end

  def compare(conduit1, conduit2) do
    case area(conduit1) - area(conduit2) do
      diff when diff > 0 -> :gt
      diff when diff < 0 -> :lt
      _ -> :eq
    end
  end

  # HELPERS

  defp round_count(count) do
    floor = floor(count)

    if count - floor < 0.8 do
      floor
    else
      floor + 1
    end
  end
end

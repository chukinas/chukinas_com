defmodule Chukinas.Wiring.WireRun do
  @moduledoc """
  Represents any number of wires - their insulation, size, and count.
  """

  require Chukinas.Wiring.WireSpec, as: WireSpec
  use TypedStruct

  typedstruct do
    field :wires, %{WireSpec.t() => pos_integer()}
  end

  defguardp is_valid_count(count) when is_integer(count) and count >= 1

  # CONSTRUCTORS

  def init() do
    %__MODULE__{wires: %{}}
  end

  # def new(wire_spec, count) when WireSpec.is_valid(wire_spec) and is_valid_count(count) do
  # init() |> add(insul, size, count)
  # end

  def new(wire_spec, count) when WireSpec.is_valid(wire_spec) and is_valid_count(count) do
    init() |> add(wire_spec, count)
  end

  def new(insul, size, count) when is_valid_count(count) do
    WireSpec.new(insul, size)
    |> new(count)
  end

  # REDUCERS

  def add(run, wire_spec, count) when WireSpec.is_valid(wire_spec) and is_valid_count(count) do
    wires = Map.update(run.wires, wire_spec, count, &(&1 + count))
    %__MODULE__{wires: wires}
  end

  def add(run, insul, size, count) when is_valid_count(count) do
    wire_spec = WireSpec.new(insul, size)
    add(run, wire_spec, count)
  end

  def merge(run, %__MODULE__{wires: wires}) do
    fun = fn {wire_spec, count}, run ->
      {insul, size} = wire_spec
      add(run, insul, size, count)
    end

    Enum.reduce(wires, run, fun)
  end

  def round_up_to_largest_wire(run) do
    largest_wire_spec =
      run.wires
      |> Map.keys()
      |> Enum.max_by(&WireSpec.area/1)

    count = count(run)
    new(largest_wire_spec, count)
  end

  # CONVERTERS

  def area(run) do
    run.wires
    |> Enum.sum_by(fn {spec, count} -> count * WireSpec.area(spec) end)
  end

  def count(run) do
    run.wires
    |> Enum.sum_by(fn {_spec, count} -> count end)
  end

  def single_spec?(run) do
    map_size(run.wires) == 1
  end
end

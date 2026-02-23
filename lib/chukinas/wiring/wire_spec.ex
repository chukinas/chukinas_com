defmodule Chukinas.Wiring.WireSpec do
  @moduledoc """
  Represents a wire type (e.g. THHN) and its size (e.g. 12AWG).

  `Chukinas.Wiring.WireSpec.t()` wraps `t()` and includes wire count.
  """

  @type insul() :: String.t()
  @type size() :: String.t()
  @opaque t() :: {insul(), size()}

  @ch9table5 Chukinas.Wiring.NECch9table5.read("thhn")
             |> Map.new(fn row ->
               key = {"thhn", row.size}
               val = row.area_in2
               {key, val}
             end)

  defguard is_valid(wire_spec) when is_map_key(@ch9table5, wire_spec)
  defguard is_valid_insul_and_size(insul, size) when is_valid({insul, size})

  # CONSTRUCTORS

  @spec new(insul(), size()) :: t()
  def new(insul = "thhn", size) when is_valid({insul, size}) do
    {insul, size}
  end

  @valid_expressions Map.keys(@ch9table5)
                     |> Enum.flat_map(fn key ->
                       fun = fn
                         size = "1/0" -> [size, "0"]
                         size = "2/0" -> [size, "00"]
                         size = "3/0" -> [size, "000"]
                         size = "4/0" -> [size, "0000"]
                         size -> [size]
                       end

                       {insul, size} = key

                       for delim <- ["", " "],
                           size <- fun.(size),
                           order <- [[insul, size], [size, insul]] do
                         string = Enum.join(order, delim)
                         {string, key}
                       end
                     end)
                     |> Map.new()
  def parse(line) do
    case @valid_expressions[line] do
      {insul, size} -> new(insul, size)
      nil -> nil
    end
  end

  # CONVERTERS

  @spec area(t()) :: float()
  def area(wire_spec) do
    Map.fetch!(@ch9table5, wire_spec)
  end

  def size({_insul, size}), do: size

  # HELPERS

  @wire_specs Map.keys(@ch9table5)
  def all_valid(), do: @wire_specs
end

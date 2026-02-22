defmodule WireCalc.NECch9table5 do
  @moduledoc """
  Loads the data found in the 2017 National Electrical Code, chapter 9, table 5.

  Table title: "Dimensions of Insulated Conductors and Fixture Wires"
  """
  alias WireCalc.PrivData

  def read(insulation_name = "thhn") do
    fun = fn %{
               "size" => size,
               "area_mm2" => area_mm2,
               "area_in2" => area_in2,
               "dia_mm" => dia_mm,
               "dia_in" => dia_in
             } ->
      %{
        size: size,
        area_mm2: String.to_float(area_mm2),
        area_in2: String.to_float(area_in2),
        dia_mm: String.to_float(dia_mm),
        dia_in: String.to_float(dia_in)
      }
    end

    PrivData.read("ch9_table5_#{insulation_name}")
    |> Enum.map(fun)
  end

  def area!(table, _insulation_name = "thhn", conductor_size) do
    Enum.find(table, &(&1.size == conductor_size)).area_in2
  end
end

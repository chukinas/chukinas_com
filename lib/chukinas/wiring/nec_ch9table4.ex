defmodule Chukinas.Wiring.NECch9table4 do
  @moduledoc """
  Loads the data found in the 2017 National Electrical Code, chapter 9, table 4.

  Table title: "Dimensions and Percent Area of Conduit and Tubing"
  """
  alias Chukinas.Wiring.PrivData

  def read(conduit_name = "emt") do
    fun = fn %{
               "metric_designator" => metric_designator,
               "trade_size" => trade_size,
               "over_2_wires_40_percent_mm2" => over_2_wires_40_percent_mm2,
               "over_2_wires_40_percent_in2" => over_2_wires_40_percent_in2,
               "one_wire_53_percent_mm2" => one_wire_53_percent_mm2,
               "one_wire_53_percent_in2" => one_wire_53_percent_in2,
               "two_wires_31_percent_mm2" => two_wires_31_percent_mm2,
               "two_wires_31_percent_in2" => two_wires_31_percent_in2,
               "nominal_internal_diameter_mm" => nominal_internal_diameter_mm,
               "nominal_internal_diameter_in" => nominal_internal_diameter_in,
               "total_area_100_percent_mm2" => total_area_100_percent_mm2,
               "total_area_100_percent_in2" => total_area_100_percent_in2
             } ->
      %{
        metric_designator: String.to_integer(metric_designator),
        trade_size: trade_size,
        over_2_wires_40_percent: %{
          mm2: String.to_integer(over_2_wires_40_percent_mm2),
          in2: String.to_float(over_2_wires_40_percent_in2)
        },
        one_wire_53_percent: %{
          mm2: String.to_integer(one_wire_53_percent_mm2),
          in2: String.to_float(one_wire_53_percent_in2)
        },
        two_wires_31_percent: %{
          mm2: String.to_integer(two_wires_31_percent_mm2),
          in2: String.to_float(two_wires_31_percent_in2)
        },
        nominal_internal_diameter: %{
          mm: String.to_float(nominal_internal_diameter_mm),
          in: String.to_float(nominal_internal_diameter_in)
        },
        total_area_100_percent: %{
          mm2: String.to_integer(total_area_100_percent_mm2),
          in2: String.to_float(total_area_100_percent_in2)
        }
      }
    end

    PrivData.read("ch9_table4_#{conduit_name}")
    |> Enum.map(fun)
  end

  def available_area!(table, _conduit_name = "thhn", trade_size, conductor_count) do
    %{} = row = Enum.find(table, &(&1.trade_size == trade_size))
    total_area = row.total_area_100_percent.in2
    percent = percent_by_wire_count(conductor_count)
    total_area * percent
  end

  def percent_by_wire_count(conductor_count) do
    case conductor_count do
      0 -> 1
      1 -> 0.53
      2 -> 0.31
      count when count > 2 -> 0.40
    end
  end
end

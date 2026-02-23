defmodule Chukinas.Wiring.NECch9table4Test do
  use ExUnit.Case
  alias Chukinas.Wiring.NECch9table4

  # The CSVs were generated via photographs of the NEC parsed by AI.
  # These tests, in converting back and forth between units, gives me the
  # confidence that parsing (and the file) is correct and matches the source material.

  defp in_to_mm(inch) do
    inch / 0.03937011
  end

  defp dia_to_area(dia) do
    :math.pi() * :math.pow(dia, 2) / 4
  end

  defp assert_same(table_value, calc_value, decimal_places \\ 0) do
    int_multiplyer = :math.pow(10, decimal_places)

    assert round(table_value * int_multiplyer) == round(calc_value * int_multiplyer), """
    table value:      #{table_value}
    calculated value: #{calc_value}
    """
  end

  # For use with the non-canonical values only
  defp assert_within(x, y) do
    assert_in_delta(x, y, 0.004 * x)
  end

  defp read do
    NECch9table4.read("emt")
  end

  describe "EMT (canonical english units)" do
    @trade_sizes ["1/2", "3/4", "1", "1 1/4", "1 1/2", "2", "2 1/2", "3", "3 1/2", "4"]
    test "trade sizes are #{Enum.join(@trade_sizes, ", ")}" do
      expected_trade_sizes = Enum.sort(@trade_sizes)
      actual_trade_sizes = read() |> Enum.map(& &1.trade_size) |> Enum.sort()
      assert expected_trade_sizes == actual_trade_sizes
    end

    test "diameter calculates correctly to area" do
      for row <- read() do
        table_in2 = row.total_area_100_percent.in2
        calc_in2 = row.nominal_internal_diameter.in |> dia_to_area()
        assert_same(table_in2, calc_in2)
      end
    end

    test "100% area converts to 40% area" do
      for row <- read() do
        table_area_40 = row.over_2_wires_40_percent.in2
        calc_area_40 = row.total_area_100_percent.in2 * 0.4
        assert_same(table_area_40, calc_area_40)
      end
    end

    test "100% area converts to 53% area" do
      for row <- read() do
        table_area_53 = row.one_wire_53_percent.in2
        calc_area_53 = row.total_area_100_percent.in2 * 0.53
        assert_same(table_area_53, calc_area_53)
      end
    end

    test "100% area converts to 31% area" do
      for row <- read() do
        table_area_31 = row.two_wires_31_percent.in2
        calc_area_31 = row.total_area_100_percent.in2 * 0.31
        assert_same(table_area_31, calc_area_31)
      end
    end
  end

  describe "EMT (metric units)" do
    @designators [16, 21, 27, 35, 41, 53, 63, 78, 91, 103]
    test "metric designators are #{Enum.join(@designators, ", ")}" do
      expected_metric_designators = Enum.sort(@designators)
      actual_metric_designators = read() |> Enum.map(& &1.metric_designator) |> Enum.sort()
      assert expected_metric_designators == actual_metric_designators
    end

    test "diameter from english" do
      for row <- read() do
        table_dia_mm = row.nominal_internal_diameter.mm
        calc_dia_mm = row.nominal_internal_diameter.in |> in_to_mm()
        assert_same(table_dia_mm, calc_dia_mm, 1)
      end
    end

    test "area from diameter" do
      for row <- read() do
        table_mm2 = row.total_area_100_percent.mm2
        calc_mm2 = row.nominal_internal_diameter.mm |> dia_to_area()
        assert_within(table_mm2, calc_mm2)
      end
    end

    test "area from english diameter" do
      for row <- read() do
        table_mm2 = row.total_area_100_percent.mm2
        calc_mm2 = row.nominal_internal_diameter.in |> in_to_mm() |> dia_to_area()
        assert_within(table_mm2, calc_mm2)
      end
    end
  end
end

defmodule Chukinas.Wiring.NECannexCtableC1Test do
  use ExUnit.Case

  # The CSVs were generated via photographs of the NEC parsed by AI.
  # These tests, in converting back and forth between units, gives me the
  # confidence that parsing (and the file) is correct and matches the source material.

  setup_all do
    {:ok, tableC1: Chukinas.Wiring.NECannexCtableC1.read("thhn")}
  end

  @trade_sizes [
    "3/8",
    "1/2",
    "3/4",
    "1",
    "1 1/4",
    "1 1/2",
    "2",
    "2 1/2",
    "3",
    "3 1/2",
    "4",
    "5",
    "6"
  ]
  test "trade sizes are #{Enum.join(@trade_sizes, ", ")}", context do
    expected_trade_sizes = Enum.sort(@trade_sizes)

    actual_trade_sizes =
      List.first(context.tableC1)
      |> Map.drop(["conductor_size"])
      |> Map.keys()
      |> Enum.sort()

    assert expected_trade_sizes == actual_trade_sizes
  end

  @excluded_trade_sizes ["3/8", "5", "6"]
  test "trade sizes #{Enum.join(@trade_sizes, ", ")} have empty values", context do
    for row <- context.tableC1, trade_size <- @excluded_trade_sizes do
      assert is_nil(Map.fetch!(row, trade_size))
    end
  end

  @wire_sizes ~w(14 12 10 8 6 4 3 2 1 1/0 2/0 3/0 4/0 250 300 350 400 500 600 700 750 800 900 1000)
  test "contains exactly wise sizes #{Enum.join(@wire_sizes, ", ")}", context do
    expected_wire_sizes = Enum.sort(@wire_sizes)
    actual_wire_sizes = Enum.map(context.tableC1, & &1["conductor_size"]) |> Enum.sort()
    assert expected_wire_sizes == actual_wire_sizes
  end

  test "wire count", context do
    for row <- context.tableC1 do
      {conductor_size, row} = Map.pop!(row, "conductor_size")
      row = Map.drop(row, @excluded_trade_sizes)
      wire_area = wire_area(conductor_size)

      for {trade_size, expected_conductor_count} <- row do
        calc_allowed_count = allowed_count(wire_area, trade_size)

        assert expected_conductor_count == calc_allowed_count, """
        Expected count:   #{expected_conductor_count}
        Calculated count: #{calc_allowed_count}
        Trade
          Size:           #{trade_size}
          Area:           #{avail_area(trade_size, 0)}
          40 (1  wire):   #{avail_area(trade_size, 1)}
          40 (2  wire):   #{avail_area(trade_size, 2)}
          40 (3+ wire):   #{avail_area(trade_size, 3)}
        Conductor
          Size:           #{conductor_size}
          Area:           #{wire_area(conductor_size)}
        """
      end
    end
  end

  @ch9table4 Chukinas.Wiring.NECch9table4.read("emt")
  defp avail_area(trade_size, conductor_count) do
    Chukinas.Wiring.NECch9table4.available_area!(@ch9table4, "thhn", trade_size, conductor_count)
  end

  @ch9table5 Chukinas.Wiring.NECch9table5.read("thhn")
  defp wire_area(conductor_size) do
    Chukinas.Wiring.NECch9table5.area!(@ch9table5, "thhn", conductor_size)
  end

  defp allowed_count(conductor_area, trade_size, count_class \\ 3)
       when is_float(conductor_area) and count_class >= 0 do
    avail_area = avail_area(trade_size, count_class)
    count = avail_area / conductor_area
    allowed_count1 = round_count(count)

    allowed_count =
      if count_class < 3 do
        min(allowed_count1, count_class)
      else
        allowed_count1
      end

    if count_class <= allowed_count do
      allowed_count
    else
      allowed_count(conductor_area, trade_size, count_class - 1)
    end
  end

  ###################################################################
  # rounding up for .8 and above
  ###################################################################

  defp round_count(count) do
    floor = floor(count)

    if count - floor < 0.8 do
      floor
    else
      floor + 1
    end
  end

  test "round count 8 -> 8" do
    assert round_count(8) == 8
  end

  test "round count 8.0 -> 8" do
    assert round_count(8.0) == 8
  end

  test "round count 8.1 -> 8" do
    assert round_count(8.1) == 8
  end

  test "round count 8.8 -> 9" do
    assert round_count(8.8) == 9
  end

  test "round count 8.9 -> 9" do
    assert round_count(8.9) == 9
  end
end

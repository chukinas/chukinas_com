defmodule WireCalc.ConduitTest do
  use ExUnit.Case
  alias WireCalc.Conduit
  alias WireCalc.WireRun
  alias WireCalc.WireSpec

  setup_all do
    row_to_list_of_cases = fn row ->
      {wire_size, row} = Map.pop(row, "conductor_size")

      row
      |> Map.drop(["—"])
      |> Enum.map(fn {conduit_trade_size, wire_count} ->
        {"emt", conduit_trade_size, "thhn", wire_size, wire_count}
      end)
      |> Enum.filter(fn {_conduit_type, _conduit_size, _insul, _wire_size, wire_count} ->
        wire_count
      end)
    end

    cases =
      WireCalc.NECannexCtableC1.read("thhn")
      |> Enum.flat_map(row_to_list_of_cases)

    {:ok, cases: cases}
  end

  test "valid_fill?/2 returns true for all cases in annex C table C1", context do
    for {conduit_type, conduit_trade_size, insul, wire_size, wire_count} when wire_count > 0 <-
          context.cases do
      conduit = Conduit.new(conduit_type, conduit_trade_size)
      wire = WireRun.new(insul, wire_size, wire_count)
      assert Conduit.valid_fill?(conduit, wire)
    end
  end

  test "valid_fill?/2 returns false for all cases plus 1 in annex C table C1", context do
    for {conduit_type, conduit_trade_size, insul, wire_size, wire_count} <-
          context.cases do
      conduit = Conduit.new(conduit_type, conduit_trade_size)
      wire = WireRun.new(insul, wire_size, wire_count + 1)
      refute Conduit.valid_fill?(conduit, wire)
    end
  end

  test "max_wire_count/2 returns the values in annex C table C1", context do
    for {conduit_type, conduit_trade_size, insul, wire_size, expected_wire_count} <- context.cases do
      wire_spec = WireSpec.new(insul, wire_size)

      calculated_wire_count =
        Conduit.new(conduit_type, conduit_trade_size)
        |> Conduit.max_wire_count(wire_spec)

      assert calculated_wire_count == expected_wire_count
    end
  end
end

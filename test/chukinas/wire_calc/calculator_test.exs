defmodule WireCalc.CalculatorTest do
  use ExUnit.Case
  alias WireCalc.Calculator
  alias WireCalc.Conduit
  alias WireCalc.Parser
  alias WireCalc.WireRun
  alias WireCalc.WireSpec

  test "sized conduit and a wire spec -> :max_wire_count" do
    assert {:max_wire_count, 16} ==
             Calculator.new()
             |> Calculator.add(Conduit.new("emt", "3/4"))
             |> Calculator.add(WireSpec.new("thhn", "12"))
             |> Calculator.process()
  end

  test "sized conduit and a wire -> {:valid_fill, true}" do
    assert {:valid_fill, true} ==
             Calculator.new()
             |> Calculator.add(Conduit.new("emt", "3/4"))
             |> Calculator.add(WireRun.new("thhn", "12", 16))
             |> Calculator.process()
  end

  test "sized conduit and a wire -> {:valid_fill, false}" do
    assert {:valid_fill, false} ==
             Calculator.new()
             |> Calculator.add(Conduit.new("emt", "3/4"))
             |> Calculator.add(WireRun.new("thhn", "12", 17))
             |> Calculator.process()
  end

  test "EMT and 666#12 THHN results in :too_much_wire error" do
    assert :too_much_wire ==
             Calculator.new()
             |> add("emt")
             |> Calculator.add(WireRun.new("thhn", "12", 666))
             |> Calculator.process()
  end

  test "unsized conduit and a wire -> {:conduit_size, ____}" do
    assert {:sized_conduit, Conduit.new("emt", "3/4")} ==
             Calculator.new()
             |> Calculator.add(Conduit.new("emt"))
             |> Calculator.add(WireRun.new("thhn", "12", 16))
             |> Calculator.process()
  end

  test "unsized EMT and a 17#12 THHN results in {:conduit_size, 1}" do
    assert {:sized_conduit, Conduit.new("emt", "1")} ==
             Calculator.new()
             |> add("emt")
             |> Calculator.add(WireRun.new("thhn", "12", 17))
             |> Calculator.process()
  end

  test "when both conduit and wire are underspecified, error" do
    assert {:error, "missing either conduit size or wire count"} =
             Calculator.new()
             |> add("emt")
             |> add("thhn 12")
             |> Calculator.process()
  end

  test "3/8 EMT and #12 THHN results in :missing error" do
    assert {:missing, :conduit} ==
             Calculator.new()
             |> add("3/8 emt")
             |> add("thhn 12")
             |> Calculator.process()
  end

  test "3/4 EMT and #13 THHN results in :missing error" do
    assert {:missing, :wire} ==
             Calculator.new()
             |> add("3/4 emt")
             |> add("thhn 13")
             |> Calculator.process()
  end

  test "When both wire and wire spec is given, the latest takes precedence." do
    assert {:max_wire_count, 16} ==
             Calculator.new()
             |> add("3/4 emt")
             |> Calculator.add(WireRun.new("thhn", "12", 10))
             |> add("thhn 12")
             |> Calculator.process()

    assert {:valid_fill, true} ==
             Calculator.new()
             |> add("3/4 emt")
             |> add("thhn 12")
             |> Calculator.add(WireRun.new("thhn", "12", 10))
             |> Calculator.process()
  end

  defp add(calculator, string) do
    if parsed = Parser.parse(string) do
      Calculator.add(calculator, parsed)
    else
      calculator
    end
  end
end

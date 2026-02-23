defmodule WireCalc.WireRunTest do
  use ExUnit.Case
  use ExUnitProperties
  alias WireCalc.Conduit
  alias WireCalc.WireRun
  alias WireCalc.WireSpec

  @sizes ~w(
    1000 900 800 750 700 600 500 400 350 300 250
    4/0 3/0 2/0 1/0
        1  2  3  4     6     8
    10    12    14    16    18
    )

  defp wire_new(size) do
    WireRun.new("thhn", size, 1)
  end

  test "new/1 fails with a size as integer" do
    assert_raise(FunctionClauseError, fn -> wire_new(12) end)
  end

  test "new/1 succeeds with a size as string" do
    for size <- @sizes do
      assert wire_new(size)
    end
  end

  test "new/1 fails with invalid size" do
    assert_raise(FunctionClauseError, fn -> wire_new("41") end)
    assert_raise(FunctionClauseError, fn -> wire_new(11) end)
  end

  defp combine_runs(runs) do
    Enum.reduce(
      runs,
      WireRun.init(),
      fn run, acc_run -> WireRun.merge(acc_run, run) end
    )
  end

  defp multi_spec_wire_run_generator() do
    gen all runs <- StreamData.list_of(single_spec_wire_run_generator(), min_length: 1) do
      combine_runs(runs)
    end
  end

  defp single_spec_wire_run_generator() do
    gen all wire_spec <- StreamData.member_of(WireSpec.all_valid()),
            count <- StreamData.positive_integer() do
      WireRun.new(wire_spec, count)
    end
  end

  property "random wire will always fit the conduit chosen for the same number of wire of the largest size" do
    check all wire_run <- multi_spec_wire_run_generator() do
      exact_sized_conduit = Conduit.new("emt", wire_run)
      wire_run_rounded_up = WireRun.round_up_to_largest_wire(wire_run)

      approximate_size_conduit =
        Conduit.new("emt", wire_run_rounded_up)

      if Conduit.has_size?(exact_sized_conduit) and Conduit.has_size?(approximate_size_conduit) do
        ordered = [exact_sized_conduit, approximate_size_conduit]
        assert ordered == Enum.sort(ordered, Conduit)
      end
    end
  end

  property "that adding more of a spec to a single-spec keeps it at single spce" do
    check all wire_spec <- StreamData.member_of(WireSpec.all_valid()),
              count1 <- StreamData.positive_integer(),
              count2 <- StreamData.positive_integer() do
      run = WireRun.new(wire_spec, count1)
      assert WireRun.single_spec?(run)
      bigger_run = WireRun.add(run, wire_spec, count2)
      assert WireRun.single_spec?(bigger_run)
    end
  end

  property "a multi-spec run has the same area as a bunch of single-specs" do
    check all singles <- StreamData.list_of(single_spec_wire_run_generator()) do
      multi = combine_runs(singles)
      singles_area = Enum.sum_by(singles, &WireRun.area/1)
      multi_area = WireRun.area(multi)
      assert_in_delta singles_area, multi_area, 0.000000001
    end
  end
end

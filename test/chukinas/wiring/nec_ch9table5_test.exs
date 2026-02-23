defmodule Chukinas.Wiring.NECch9table5Test do
  use ExUnit.Case
  alias Chukinas.Wiring.NECch9table5

  # The CSVs were generated via photographs of the NEC parsed by AI.
  # These tests, in converting back and forth between units, gives me the
  # confidence that parsing (and the file) is correct and matches the source material.

  @in_over_mm 0.03937011
  @in2_over_mm2 @in_over_mm * @in_over_mm

  defp read do
    NECch9table5.read("thhn")
  end

  describe "read(\"thhn\")" do
    @row_count 26
    test "has #{@row_count} rows" do
      assert @row_count == length(read())
    end

    test "converts area from in2 to mm2" do
      for row <- read() do
        # The mm column switches from 3 decimals to 2 starting at #1 (11.33mm).
        # It's still 4 sigfigs though.
        # The previous size is #2 (9.754mm)
        mult =
          case row.area_mm2 do
            area when area < 13 -> 1000
            area when area < 100 -> 100
            _ -> 10
          end

        assert round(mult * row.area_mm2) == round(mult * row.area_in2 / @in2_over_mm2)
      end
    end

    test "converts area from mm2 to in2" do
      for row <- read() do
        mult =
          if row.size in ~w(3/0 4/0 400 600 750 800 900 1000) do
            # The metric sizes are not cannonical.
            # They're provided for reference.
            # Some therefore don't convert back to english.
            # In these cases, we compare using less precision.
            1000
          else
            10000
          end

        assert round(mult * row.area_in2) == round(mult * row.area_mm2 * @in2_over_mm2)
      end
    end

    test "converts diameter from in to mm" do
      for row <- read() do
        # The mm column switches from 3 decimals to 2 starting at #1 (11.33mm).
        # It's still 4 sigfigs though.
        # The previous size is #2 (9.754mm)
        mult =
          if row.dia_mm < 11 do
            1000
          else
            100
          end

        assert round(mult * row.dia_mm) == round(mult * row.dia_in / @in_over_mm)
      end
    end

    test "converts diameter from mm to in" do
      for row <- read() do
        assert round(1000 * row.dia_in) == round(1000 * row.dia_mm * @in_over_mm)
      end
    end
  end
end

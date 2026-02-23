defmodule Chukinas.Wiring.ParserTest do
  use ExUnit.Case
  alias Chukinas.Wiring.Conduit
  alias Chukinas.Wiring.Parser
  alias Chukinas.Wiring.WireSpec

  @test_cases [
    {Conduit.new("emt", "1/2"), "emt 1/2"},
    {Conduit.new("emt", "1/2"), "emt_1/2"},
    {Conduit.new("emt", "1/2"), "emt1/2"},
    {Conduit.new("emt", "1/2"), "   emt 1/2   "},
    {Conduit.new("emt", "1/2"), "   emt  1/2   "},
    {Conduit.new("emt", "1/2"), "EMT 1/2"},
    {Conduit.new("emt", "1/2"), "Emt 1/2"},
    {Conduit.new("emt", "1/2"), "eMt 1/2"},
    {Conduit.new("emt", "1/2"), "1/2 emt"},
    {Conduit.new("emt", "1/2"), "1/2     emt"},
    {Conduit.new("emt", "1/2"), "1/2emt"},
    {Conduit.new("emt", "1/2"), "   1/2emt"},
    {Conduit.new("emt", "1 1/2"), "emt 1_1/2"},
    {Conduit.new("emt", "1 1/2"), "emt  1  1/2"},
    {nil, "13/16 emt"},
    {nil, "11/2 emt"},
    {Conduit.new("emt"), "   emt"},
    {WireSpec.new("thhn", "12"), "thhn 12"},
    {WireSpec.new("thhn", "12"), "thhn #12"},
    {WireSpec.new("thhn", "12"), "thhn 12AWG"},
    {WireSpec.new("thhn", "12"), "thhn    12"},
    {WireSpec.new("thhn", "12"), "12 thhn  "},
    {WireSpec.new("thhn", "4/0"), "4/0   thhn  "},
    {WireSpec.new("thhn", "4/0"), "4/0 AWG   thhn  "},
    {WireSpec.new("thhn", "4/0"), "#4/0   thhn  "},
    {WireSpec.new("thhn", "4/0"), "# 4/0   thhn  "},
    {WireSpec.new("thhn", "4/0"), "0000 thhn  "},
    {nil, " "},
    {nil, "# "},
    {nil, "AWG "},
    {nil, ""}
  ]

  for {result, input} <- @test_cases do
    @input input
    @result result
    test "Parser.parse(#{inspect(input)}) results in #{inspect(result)}" do
      assert Parser.parse(@input) == @result
    end
  end
end

defmodule WireCalc.Parser do
  @moduledoc """
  Parse each line of a paragraph of text.

  Not responsible for handling any larger logic,
  like if two lines specify different conduits
  """

  alias WireCalc.Conduit
  alias WireCalc.WireRun
  alias WireCalc.WireSpec
  use TypedStruct

  @typep parsed_data_structure() :: Conduit.t() | WireSpec.t() | WireRun.t() | nil
  @typep row() :: {orig_string :: String.t(), parsed_data_structure()}
  @opaque t() :: [row()]

  # CONSTRUCTORS

  def parse(string) when is_binary(string) do
    string =
      string
      |> String.downcase()
      |> String.replace(~r/#|awg/, " ")
      |> String.replace(~r/[_\s]+/, " ")
      |> String.trim()

    Conduit.parse(string) || WireSpec.parse(string)
  end

  # CONVERTERS
end

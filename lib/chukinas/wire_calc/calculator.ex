defmodule WireCalc.Calculator do
  @moduledoc """
  Handles unstructured user input, interprets intent, returns the missing piece of information.
  """

  alias WireCalc.Conduit
  alias WireCalc.WireRun
  require WireCalc.WireSpec, as: WireSpec
  use TypedStruct

  typedstruct do
    field :conduit, Conduit.t()
    field :wire, WireRun.t()
    field :wire_spec, WireSpec.t()
  end

  # CONSTRUCTORS

  def new(), do: %__MODULE__{}

  # REDUCERS

  def add(calc, %Conduit{} = conduit) do
    %{calc | conduit: conduit}
  end

  def add(calc, %WireRun{} = wire) do
    %{calc | wire: wire, wire_spec: nil}
  end

  def add(calc, wire_spec) when WireSpec.is_valid(wire_spec) do
    %{calc | wire: nil, wire_spec: wire_spec}
  end

  # CONVERTERS

  def process(%__MODULE__{conduit: conduit, wire: wire, wire_spec: wire_spec}) do
    cond do
      !conduit ->
        {:missing, :conduit}

      !wire and !wire_spec ->
        {:missing, :wire}

      Conduit.has_size?(conduit) and wire ->
        {:valid_fill, Conduit.valid_fill?(conduit, wire)}

      Conduit.has_size?(conduit) and wire_spec ->
        {:max_wire_count, Conduit.max_wire_count(conduit, wire_spec)}

      !Conduit.has_size?(conduit) and wire ->
        maybe_sized_conduit = Conduit.new(conduit.type, wire)

        if Conduit.has_size?(maybe_sized_conduit) do
          {:sized_conduit, maybe_sized_conduit}
        else
          :too_much_wire
        end

      !Conduit.has_size?(conduit) and wire_spec ->
        {:error, "missing either conduit size or wire count"}
    end
  end
end

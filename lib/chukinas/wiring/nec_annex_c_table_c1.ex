defmodule Chukinas.Wiring.NECannexCtableC1 do
  @moduledoc """
  Loads the data found in the 2017 National Electrical Code, chapter 9, table 4.

  Table title: "Dimensions and Percent Area of Conduit and Tubing"
  """
  alias Chukinas.Wiring.PrivData

  def read(wire_type = "thhn") do
    fun =
      &Map.new(&1, fn
        {"conductor_size", conductor_size} -> {"conductor_size", conductor_size}
        {conduit_size, "—"} -> {conduit_size, nil}
        {conduit_size, value} -> {conduit_size, String.to_integer(value)}
      end)

    PrivData.read("annexC_tableC1_#{wire_type}")
    |> Enum.map(fun)
  end
end

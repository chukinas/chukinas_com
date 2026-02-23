defmodule Chukinas.Wiring.PrivData do
  @moduledoc """
  Load the data found in priv/data.
  """

  defp path(filename) do
    Path.join(:code.priv_dir(:chukinas), "data/#{filename}.csv")
  end

  def read(filename) do
    path(filename)
    |> File.stream!()
    |> CSV.decode!(headers: true)
  end
end

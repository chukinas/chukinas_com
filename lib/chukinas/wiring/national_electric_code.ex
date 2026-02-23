defmodule Chukinas.Wiring.NationalElectricCode do
  @moduledoc """
  Load the data found in priv/national_electric_code.
  """

  defp path(filename) do
    Path.join(:code.priv_dir(:chukinas), "national_electric_code/#{filename}.csv")
  end

  def read(filename) do
    path(filename)
    |> File.stream!()
    |> CSV.decode!(headers: true)
  end
end

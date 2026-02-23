defmodule Chukinas.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ChukinasWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:chukinas, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Chukinas.PubSub},
      # Start a worker by calling: Chukinas.Worker.start_link(arg)
      # {Chukinas.Worker, arg},
      # Start to serve requests, typically the last entry
      # TODO rename
      BidTracker.EventStore,
      BidTracker.ActiveBids,
      ChukinasWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Chukinas.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ChukinasWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

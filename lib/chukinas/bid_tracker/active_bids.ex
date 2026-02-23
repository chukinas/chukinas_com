defmodule BidTracker.ActiveBids do
  @moduledoc """
  This module is the source of truth for Active Bids.

  ~p"/active" gets its table from here.
  Whenever this genserver changes state, it uses phoenix channels to alert the liveviews following it.
  They'll then call this function again.
  """

  use GenServer
  alias BidTracker.EventStore
  alias BidTracker.Message

  @topic "active_bids"

  # Client

  def start_link(opts) do
    {name, opts} = Keyword.pop(opts, :name, __MODULE__)
    GenServer.start_link(__MODULE__, opts, name: name)
  end

  def get(name \\ __MODULE__) do
    Process.registered() |> Enum.sort()
    GenServer.call(name, :get)
  end

  def delete(name \\ __MODULE__, uuid) do
    GenServer.cast(name, {:delete, uuid})
    :ok
  end

  # Server

  @impl true
  def init(opts) do
    event_store = opts[:event_store_name] || EventStore

    ChukinasWeb.DummyActiveBids.get_without_uuid()
    |> Enum.take(10)
    |> Enum.with_index()
    |> Enum.each(fn {fields, index} ->
      :ok = EventStore.add_new_event(event_store, index, "active_bid_created", fields)
    end)

    active_bids =
      EventStore.get_events(event_store, ["active_bid_created"])
      |> Enum.map(fn %Message{uuid: uuid, fields: fields} -> Map.put(fields, :uuid, uuid) end)

    {:ok, active_bids}
  end

  @impl true
  def handle_call(:get, _from, state) do
    {:reply, state, state}
  end

  @impl true
  def handle_cast({:delete, uuid}, state) do
    state = Enum.reject(state, fn active_bid -> active_bid.uuid == uuid end)

    Phoenix.PubSub.broadcast(
      Chukinas.PubSub,
      @topic,
      {:active_bids_updated, "Bid #{uuid} deleted", state}
    )

    {:noreply, state}
  end
end

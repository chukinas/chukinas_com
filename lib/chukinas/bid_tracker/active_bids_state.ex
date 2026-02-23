# TODO add some tests
defmodule BidTracker.ActiveBidsState do
  # TODO add moduledoc
  alias BidTracker.Message

  # CONSTRUCTORS

  def new() do
    %{}
  end

  # REDUCERS

  # TODO handle_event should automatically grab the event name and save it to a list
  # easily called by Owner
  def handle_event(state, "active_bid_created", %Message{} = event) do
    new_active_bid = Map.put(event.fields, :uuid, event.uuid)
    Map.put(state, :uuid, new_active_bid)
  end

  def handle_event(state, "active_bid_deleted", %Message{uuid: uuid}) do
    Map.delete(state, uuid)
  end

  # CONVERTERS

  # defp get_sorted(state) do
  #   state
  #   |> Map.values()
  #   |> Enum.sort(& &1.bid_number)
  # end
end

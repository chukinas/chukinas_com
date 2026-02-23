# TODO align file name and module name
# TODO add some tests
# TODO move to its own module
defmodule BidTracker.Messbugg.Owner do
  alias BidTracker.Message
  # TODO what is this "Owner" actually called?
  defstruct [:global_id, :state]

  def new(owner_module) do
    %__MODULE__{global_id: 0, state: owner_module.new()}
  end

  # TODO extract the checks
  def handle_event(%__MODULE__{} = owner, message_name, %Message{} = event) do
    new_state = BidTracker.ActiveBidsState.handle_event(owner.state, message_name, event)
    %__MODULE__{owner | global_id: event.global_id, state: new_state}
  end
end

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

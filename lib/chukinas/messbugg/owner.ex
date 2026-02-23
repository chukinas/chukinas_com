defmodule Chukinas.Messbugg.Owner do
  alias BidTracker.Message
  alias Chukinas.Bids.ActiveBidsState

  defstruct [:global_id, :state]

  def new(owner_module) do
    %__MODULE__{global_id: 0, state: owner_module.new()}
  end

  def handle_event(%__MODULE__{} = owner, message_name, %Message{} = event) do
    new_state = ActiveBidsState.handle_event(owner.state, message_name, event)
    %__MODULE__{owner | global_id: event.global_id, state: new_state}
  end
end

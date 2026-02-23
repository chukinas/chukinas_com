defmodule BidTracker.ActiveBidsTest do
  alias BidTracker.EventStore
  use ExUnit.Case, async: true

  @name :test_event_store_2

  setup do
    start_supervised({EventStore, name: @name})
    :ok
  end

  test "When ActiveBids starts up, it sends some starting messages to EventStore" do
    assert 0 = EventStore.global_id(@name)
    start_supervised({BidTracker.ActiveBids, event_store_name: @name, name: :active_bids_test})
    assert EventStore.global_id(@name) > 0
  end
end

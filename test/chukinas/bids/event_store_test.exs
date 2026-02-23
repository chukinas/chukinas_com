defmodule Chukinas.Bids.EventStoreTest do
  alias Chukinas.Bids.EventStore
  use ExUnit.Case, async: true

  @name :test_event_store

  setup do
    start_supervised({EventStore, name: @name})
    :ok
  end

  test "global_id/1 returns 0 when there are no messages" do
    assert 0 = EventStore.global_id(@name)
  end

  test "global_id/1 returns 1 after having rcv'ed a message" do
    :ok = EventStore.add_new_event(@name, 0, "something_happened", %{})
    assert 1 = EventStore.global_id(@name)
  end

  test "add_new_event/3 returns :ok when global id is current" do
    assert :ok = EventStore.add_new_event(@name, 0, "something_happened", %{})
  end

  test "add_new_event/3 returns :error when global id is not current" do
    assert :error = EventStore.add_new_event(@name, 1, "something_happened", %{})
  end
end

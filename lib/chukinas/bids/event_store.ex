defmodule Chukinas.Bids.EventStore do
  alias Chukinas.Messbugg.Message
  use Agent

  def start_link(opts) do
    opts = Keyword.put_new(opts, :name, __MODULE__)
    Agent.start_link(fn -> [] end, opts)
  end

  def global_id(name \\ __MODULE__) do
    Agent.get(name, &_global_id/1)
  end

  def get_events(name \\ __MODULE__, message_names) do
    fun = fn messages ->
      Enum.filter(messages, &(&1.name in message_names))
    end

    Agent.get(name, fun)
  end

  def add_new_event(name \\ __MODULE__, expected_current_global_id, event_name, fields) do
    fun = fn messages ->
      global_id = _global_id(messages)

      if expected_current_global_id == global_id do
        event = Message.new(global_id + 1, event_name, fields)
        new_messages = [event | messages]
        {:ok, new_messages}
      else
        {:error, messages}
      end
    end

    Agent.get_and_update(name, fun)
  end

  # CONVERTERS

  defp _global_id(messages) do
    case messages do
      [%Message{} = event | _rest] -> event.global_id
      [] -> 0
    end
  end
end

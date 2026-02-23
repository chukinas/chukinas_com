defmodule BidTracker.Message do
  defstruct [:global_id, :uuid, :fields, :type, :name]

  def new(global_id, name, %{} = fields) when is_binary(name) and is_integer(global_id) do
    %__MODULE__{
      global_id: global_id,
      uuid: Ecto.UUID.generate(),
      fields: fields,
      type: :event,
      name: name
    }
  end
end

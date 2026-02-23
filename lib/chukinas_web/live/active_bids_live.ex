defmodule ChukinasWeb.ActiveBidsLive do
  use ChukinasWeb, :live_view
  alias Chukinas.Bids.ActiveBids

  @topic "active_bids"

  def mount(_params, _session, socket) do
    if connected?(socket) do
      Phoenix.PubSub.subscribe(Chukinas.PubSub, @topic)
    end

    {:ok,
     assign(socket,
       page_title: "Active Bids",
       add_button: false,
       active_bids: ActiveBids.get()
     )}
  end

  def handle_info({:active_bids_updated, message, active_bids}, socket) do
    {:noreply,
     socket
     |> put_flash(:info, message)
     |> assign(active_bids: active_bids)}
  end

  def handle_event("edit", %{"uuid" => uuid}, socket) do
    socket = put_flash(socket, :info, "PLACEHOLDER. Editing bid #{uuid}")
    {:noreply, socket}
  end

  def handle_event("delete", %{"uuid" => uuid}, socket) do
    :ok = ActiveBids.delete(uuid)

    {:noreply,
     socket
     |> put_flash(:info, "Deleting bid #{uuid}...")}
  end
end

# TODO mv to chukinas_web/live/bids/active...
defmodule ChukinasWeb.Bids.ActiveBidsLiveTest do
  use ChukinasWeb.ConnCase
  import Phoenix.LiveViewTest
  alias Chukinas.Bids.ActiveBids

  defp rand_bid() do
    ActiveBids.get() |> Enum.random()
  end

  test "renders active bids page", %{conn: conn} do
    {:ok, _view, html} = live(conn, ~p"/active")

    assert html =~ "Active Bids"
  end

  test "shows flash message when specific bid is edited", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/active")
    %{uuid: uuid} = rand_bid()

    view
    |> element("button[phx-click='edit'][phx-value-uuid='#{uuid}']")
    |> render_click()

    assert render(view) =~ "PLACEHOLDER. Editing bid #{uuid}"
  end

  test "deleting a bid removes it from list", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/active")
    %{project_name: project_name, uuid: uuid} = rand_bid()

    assert render(view) =~ project_name

    view
    |> element("button[phx-click='delete'][phx-value-uuid='#{uuid}']")
    |> render_click()

    refute render(view) =~ project_name
  end
end

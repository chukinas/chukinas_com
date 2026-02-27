defmodule ChukinasWeb.Bids.ActiveBidsLiveTest do
  alias Chukinas.Bids.ActiveBids
  use ChukinasWeb.ConnCase
  import Phoenix.LiveViewTest

  defp rand_bid() do
    ActiveBids.get() |> Enum.random()
  end

  defp path, do: ~p"/liberty/bids/active"

  test "renders active bids page", %{conn: conn} do
    {:ok, _view, html} = live(conn, path())

    assert html =~ "Active Bids"
  end

  test "shows flash message when specific bid is edited", %{conn: conn} do
    {:ok, view, _html} = live(conn, path())
    %{uuid: uuid} = rand_bid()

    view
    |> element("button[phx-click='edit'][phx-value-uuid='#{uuid}']")
    |> render_click()

    assert render(view) =~ "PLACEHOLDER. Editing bid #{uuid}"
  end

  test "deleting a bid removes it from list", %{conn: conn} do
    import Phoenix.HTML
    {:ok, view, _html} = live(conn, path())
    %{project_name: project_name, uuid: uuid} = rand_bid()

    project_name = html_escape(project_name) |> safe_to_string()
    assert render(view) =~ project_name

    view
    |> element("button[phx-click='delete'][phx-value-uuid='#{uuid}']")
    |> render_click()

    refute render(view) =~ project_name
  end
end

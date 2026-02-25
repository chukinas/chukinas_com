defmodule ChukinasWeb.RedirectControllerTest do
  use ChukinasWeb.ConnCase

  test "GET / redirects to /active", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert redirected_to(conn) == ~p"/liberty/bids/active"
  end
end

defmodule BidTrackerWeb.RedirectControllerTest do
  use ChukinasWeb.ConnCase

  test "GET / redirects to /active", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert redirected_to(conn) == ~p"/active"
  end
end

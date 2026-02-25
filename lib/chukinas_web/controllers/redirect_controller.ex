defmodule ChukinasWeb.RedirectController do
  use ChukinasWeb, :controller

  def active_bids(conn, _params) do
    redirect(conn, to: ~p"/liberty/bids/active")
  end
end

defmodule ChukinasWeb.RedirectController do
  use ChukinasWeb, :controller

  def redirect_to_active(conn, _params) do
    redirect(conn, to: ~p"/liberty/bids/active")
  end
end

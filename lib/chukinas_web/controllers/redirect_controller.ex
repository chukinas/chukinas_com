defmodule ChukinasWeb.RedirectController do
  use ChukinasWeb, :controller

  def redirect_to_active(conn, _params) do
    redirect(conn, to: ~p"/active")
  end
end

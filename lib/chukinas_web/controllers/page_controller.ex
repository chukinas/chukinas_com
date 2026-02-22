defmodule ChukinasWeb.PageController do
  use ChukinasWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end

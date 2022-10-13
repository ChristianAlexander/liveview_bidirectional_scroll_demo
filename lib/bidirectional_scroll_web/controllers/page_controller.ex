defmodule BidirectionalScrollWeb.PageController do
  use BidirectionalScrollWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end

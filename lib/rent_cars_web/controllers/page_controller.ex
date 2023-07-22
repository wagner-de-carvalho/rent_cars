defmodule RentCarsWeb.PageController do
  use RentCarsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end

defmodule RentCarsWeb.Api.CategoryController do
  use RentCarsWeb, :controller

  def index(conn, _params) do
    conn
    |> put_status(:ok)
    |> json(%{
      data: [
        %{
          id: "123",
          desception: "acme 123",
          name: "SPORT"
        }
      ]
    })
  end
end

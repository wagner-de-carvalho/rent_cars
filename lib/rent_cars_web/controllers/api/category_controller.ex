defmodule RentCarsWeb.Api.CategoryController do
  use RentCarsWeb, :controller
  alias RentCars.Categories

  def index(conn, _params) do
    categories = Categories.list_categories()

    conn
    |> put_status(:ok)
    |> render("index.json", categories: categories)
  end
end

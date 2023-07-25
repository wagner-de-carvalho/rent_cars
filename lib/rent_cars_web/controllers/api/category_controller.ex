defmodule RentCarsWeb.Api.CategoryController do
  use RentCarsWeb, :controller
  alias RentCars.Categories
  alias RentCars.Categories.Category
  alias RentCarsWeb.Api.FallbackController

  action_fallback FallbackController

  def index(conn, _params) do
    with categories <- Categories.list_categories() do
      conn
      |> put_status(:ok)
      |> render("index.json", categories: categories)
    end
  end

  # def create(conn, %{"category" => category}) do
  def create(conn, category) do
    with {:ok, category} <- Categories.create_category(category) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.api_category_path(conn, :show, category))
      |> render("show.json", category: category)
    end
  end

  def show(conn, %{"id" => id}) do
    with %Category{} = category <- Categories.get_category(id) do
      conn
      |> put_status(:ok)
      |> render("show.json", category: category)
    end
  end
end

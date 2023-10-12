defmodule RentCarsWeb.Api.RentalController do
  use RentCarsWeb, :controller
  alias RentCars.Rentals
  alias RentCarsWeb.FallbackController

  action_fallback FallbackController

  def create(conn, args) do
    [user_id] = get_req_header(conn, "user_id")
    args = Map.put(args, "user_id", user_id)

    with {:ok, %{rental: rental}} <- Rentals.create(args) do
      conn
      |> put_status(:created)
      |> render("show.json", rental: rental)
    end
  end

  def index(conn, _args) do
    [user_id] = get_req_header(conn, "user_id")

    with rentals when is_list(rentals) <-
           Rentals.list_rentals(user_id) do
      conn
      |> put_status(:ok)
      |> render("index.json", rentals: rentals)
    end
  end

  def return(conn, %{"id" => id}) do
    [user_id] = get_req_header(conn, "user_id")

    with %{rental: {:ok, %{return_car: rental}}} <- Rentals.return_car(id, user_id) do
      conn
      |> put_status(:created)
      |> render("show.json", rental: rental)
    end
  end
end

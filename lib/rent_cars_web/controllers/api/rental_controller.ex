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
end

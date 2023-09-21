defmodule RentCarsWeb.Api.Admin.CarController do
  use RentCarsWeb, :controller
  alias RentCars.Cars
  alias RentCarsWeb.FallbackController

  action_fallback FallbackController

  def create(conn, car) do
    with {:ok, car} <- Cars.create(car) do
      conn
      |> put_status(:created)
      |> render("show.json", car: car)
    end
  end

  def show(conn, %{"id" => id}) do
    car = Cars.get_car!(id)

    conn
    |> put_status(:ok)
    |> render("show.json", car: car)
  end

  def update(conn, %{"id" => id} = car_params) do
    with {:ok, updated_car} <- Cars.update(id, car_params) do
      conn
      |> put_status(:ok)
      |> render("show.json", car: updated_car)
    end
  end
end

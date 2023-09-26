defmodule RentCarsWeb.Api.CarController do
  use RentCarsWeb, :controller
  alias RentCars.Cars
  alias RentCarsWeb.FallbackController

  action_fallback FallbackController

  def index(conn, params) do
    params = to_keywordlist(params)

    with cars when is_list(cars) <- Cars.list_cars(params) do
      conn
      |> put_status(:ok)
      |> render("index.json", cars: cars)
    end
  end

  defp to_keywordlist(params),
    do: Enum.map(params, fn {key, filter} -> {String.to_atom(key), filter} end)
end

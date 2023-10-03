defmodule RentCars.Rentals.CreateRental do
  import RentCars.Shared.DateValidations, only: [check_if_is_more_than_24: 1]
  alias RentCars.Cars.Car
  alias RentCars.Repo

  def execute(car_id, expected_return_date) do
    with true <- check_if_is_more_than_24(expected_return_date),
         {:ok, car} <- car_available(car_id) do
      car
    else
      error -> error
    end
  end

  defp car_available(car_id) do
    Car
    |> Repo.get(car_id)
    |> check_car_availability()
  end

  defp check_car_availability(%{available: false}), do: {:error, "Car is unavailable"}
  defp check_car_availability(%{available: true} = car), do: {:ok, car}
end

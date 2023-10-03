defmodule RentCars.Rentals.CreateRental do
  import Ecto.Query
  import RentCars.Shared.DateValidations, only: [check_if_is_more_than_24: 1]
  alias RentCars.Accounts.User
  alias RentCars.Cars.Car
  alias RentCars.Repo

  def execute(car_id, expected_return_date, user_id) do
    with true <- check_if_is_more_than_24(expected_return_date),
         {:ok, car} <- car_available(car_id),
         true <- user_booked_car?(user_id) do
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

  defp user_booked_car?(user_id) do
    User
    |> join(:inner, [user], rental in assoc(user, :rentals))
    |> where([user, _rental], user.id == ^user_id)
    |> where([_user, rental], is_nil(rental.end_date))
    |> select([user, _rental], count(user.id))
    |> Repo.one()
    |> then(&(&1 == 0 || {:error, "User has a reservation"}))
  end
end

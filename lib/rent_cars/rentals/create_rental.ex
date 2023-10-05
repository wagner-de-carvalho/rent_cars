defmodule RentCars.Rentals.CreateRental do
  import Ecto.Query
  import RentCars.Shared.DateValidations, only: [check_if_is_more_than_24: 1]
  alias Ecto.Multi
  alias RentCars.Accounts.User
  alias RentCars.Cars.Car
  alias RentCars.Rentals.Rental
  alias RentCars.Repo

  def execute(car_id, expected_return_date, user_id) do
    with true <- check_if_is_more_than_24(expected_return_date),
         {:ok, car} <- car_available(car_id),
         true <- user_booked_car?(user_id) do
      book_car(car, expected_return_date, user_id)
    else
      error -> error
    end
  end

  defp car_available(car_id) do
    Car
    |> Repo.get(car_id)
    |> check_car_availability()
  end

  defp user_booked_car?(user_id) do
    User
    |> join(:inner, [user], rental in assoc(user, :rentals))
    |> where([user, _rental], user.id == ^user_id)
    |> where([_user, rental], is_nil(rental.end_date))
    |> select([user, _rental], count(user.id))
    |> Repo.one()
    |> then(&(&1 == 0 || {:error, "User has a reservation"}))
  end

  defp book_car(car, expected_return_date, user_id) do
    payload = %{
      expected_return_date: expected_return_date,
      start_date: NaiveDateTime.utc_now(),
      car_id: car.id,
      user_id: user_id
    }

    Multi.new()
    |> Multi.update(:set_car_unavailable, Car.changeset(car, %{available: false}))
    |> Multi.insert(:rental, Rental.changeset(payload))
    |> Repo.transaction()
  end

  defp check_car_availability(%{available: false}), do: {:error, "Car is unavailable"}
  defp check_car_availability(%{available: true} = car), do: {:ok, car}
end

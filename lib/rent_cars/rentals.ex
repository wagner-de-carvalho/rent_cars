defmodule RentCars.Rentals do
  import Ecto.Query
  alias __MODULE__.CreateRental
  alias __MODULE__.Rental
  alias __MODULE__.ReturnCar
  alias RentCars.Repo

  def create(payload) do
    %{
      "car_id" => car_id,
      "expected_return_date" => expected_return_date,
      "user_id" => user_id
    } = payload

    CreateRental.execute(car_id, expected_return_date, user_id)
  end

  def list_rentals(user_id) do
    Rental
    |> where([rental], rental.user_id == ^user_id)
    |> preload(car: [:category, :specifications])
    |> Repo.all()
  end

  defdelegate return_car(rental_id, user_id), to: ReturnCar, as: :execute
end

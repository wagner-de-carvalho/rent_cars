defmodule RentCars.Rentals.ReturnCar do
  import Ecto.Query
  alias RentCars.Rentals.Rental
  alias RentCars.Repo

  defstruct rental: nil, days: nil, delay: nil

  def execute(rental_id, user_id) do
    with %__MODULE__{} = return_rental <- get_rental(rental_id, user_id),
         return_rental <- calculate_delay(return_rental) do
      return_rental
    else
      error -> error
    end
  end

  defp get_rental(rental_id, user_id) do
    error = {:error, "Car reservation does not exist"}

    result = fn rental ->
      rental != nil && %__MODULE__{rental: Repo.preload(rental, :car)}
    end

    Rental
    |> where([rental], rental.id == ^rental_id)
    |> where([rental], rental.user_id == ^user_id)
    |> Repo.one()
    |> then(&(result.(&1) || error))
  end

  defp calculate_delay(%{rental: rental} = return_car) do
    now = NaiveDateTime.utc_now()
    days = Timex.diff(now, rental.start_date, :days)
    delay = Timex.diff(now, rental.expected_return_date, :days)
    %{return_car | days: days, delay: delay}
  end
end

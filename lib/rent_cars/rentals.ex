defmodule RentCars.Rentals do
  alias __MODULE__.CreateRental

  def create(payload) do
    %{
      "car_id" => car_id,
      "expected_return_date" => expected_return_date,
      "user_id" => user_id
    } = payload

    CreateRental.execute(car_id, expected_return_date, user_id)
  end
end

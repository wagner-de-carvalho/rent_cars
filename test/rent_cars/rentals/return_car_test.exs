defmodule RentCars.Rentals.ReturnCarTest do
  use RentCars.DataCase
  import RentCars.AccountsFixtures
  import RentCars.CarsFixtures
  import RentCars.RentalsFixtures
  alias Ecto.UUID
  alias RentCars.Rentals.ReturnCar

  describe "return_car/1" do
    setup do
      car = car_fixture(%{available: false})
      user = user_fixture()

      %{car: car, user: user}
    end

    test "throws an error when reservation does not exist" do
      assert {:error, "Car reservation does not exist"} ==
               ReturnCar.execute(UUID.generate(), UUID.generate())
    end

    test "calculate return date and delay", %{car: car, user: user} do
      today = Date.utc_today()
      expected_return_date = Timex.shift(today, days: -5) |> Timex.to_naive_datetime()
      start_date = Timex.shift(today, days: -7) |> Timex.to_naive_datetime()

      rental =
        rental_fixture(%{
          car_id: car.id,
          user_id: user.id,
          expected_return_date: expected_return_date,
          start_date: start_date
        })

      assert %{days: 7, delay: 5} = ReturnCar.execute(rental.id, user.id)
    end
  end
end

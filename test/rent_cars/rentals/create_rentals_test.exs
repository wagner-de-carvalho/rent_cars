defmodule RentCars.Rentals.CreateRentalsTest do
  use RentCars.DataCase
  import RentCars.CarsFixtures
  alias RentCars.Rentals.CreateRental

  describe "create_rentals/1" do
    test "throws an error when car is not available" do
      car = car_fixture(%{available: false})

      expected_return_date =
        NaiveDateTime.utc_now()
        |> then(&%{&1 | month: &1.month + 1})
        |> NaiveDateTime.to_string()

      assert({:error, "Car is unavailable"} == CreateRental.execute(car.id, expected_return_date))
    end

    test "throws an error when car return date is before 24 hours" do
      car = car_fixture(%{available: true})

      expected_return_date =
        NaiveDateTime.utc_now()
        |> then(&%{&1 | hour: &1.hour + 5})
        |> NaiveDateTime.to_string()

      assert(
        {:error, "Invalid return date"} == CreateRental.execute(car.id, expected_return_date)
      )
    end
  end
end

defmodule RentCars.Rentals.CreateRentalsTest do
  use RentCars.DataCase
  import RentCars.CarsFixtures
  import RentCars.AccountsFixtures
  import RentCars.RentalsFixtures
  alias RentCars.Rentals.CreateRental

  describe "execute/2" do
    setup do
      car_available = car_fixture(%{available: true})
      car_unavailable = car_fixture(%{available: false})
      user = user_fixture()

      %{car_available: car_available, car_unavailable: car_unavailable, user: user}
    end

    test "throws an error when car is not available", %{car_unavailable: car, user: user} do
      expected_return_date =
        NaiveDateTime.utc_now()
        |> then(&%{&1 | month: &1.month + 1})
        |> NaiveDateTime.to_string()

      assert(
        {:error, "Car is unavailable"} ==
          CreateRental.execute(car.id, expected_return_date, user.id)
      )
    end

    test "throws an error when date is before 24 hours", %{car_available: car, user: user} do
      expected_return_date =
        NaiveDateTime.utc_now(Calendar.ISO)
        |> then(&%{&1 | hour: &1.hour + 2})
        |> NaiveDateTime.to_string()

      assert {:error, "Invalid return date"} ==
               CreateRental.execute(car.id, expected_return_date, user.id)
    end

    test "should throw an error when user has booked a car", %{car_available: car, user: user} do
      rental_fixture(%{car_id: car.id, user_id: user.id})

      expected_return_date =
        NaiveDateTime.utc_now()
        |> then(&%{&1 | month: &1.month + 1})
        |> NaiveDateTime.to_string()

      assert {:error, "User has a reservation"} ==
               CreateRental.execute(car.id, expected_return_date, user.id)
    end
  end
end

defmodule RentCars.Rentals.CreateRentalsTest do
  use RentCars.DataCase
  import RentCars.CarsFixtures
  import RentCars.AccountsFixtures
  import RentCars.RentalsFixtures
  alias RentCars.Cars
  alias RentCars.Rentals.CreateRental

  describe "execute/2" do
    setup do
      car_available = car_fixture(%{available: true})
      car_unavailable = car_fixture(%{available: false})
      user = user_fixture()

      %{car_available: car_available, car_unavailable: car_unavailable, user: user}
    end

    test "throws an error when car is not available", %{car_unavailable: car, user: user} do
      expected_return_date = create_expected_return_date()

      assert(
        {:error, "Car is unavailable"} ==
          CreateRental.execute(car.id, expected_return_date, user.id)
      )
    end

    test "throws an error when date is before 24 hours", %{car_available: car, user: user} do
      expected_return_date = create_expected_return_hour_date()

      assert {:error, "Invalid return date"} ==
               CreateRental.execute(car.id, expected_return_date, user.id)
    end

    test "should throw an error when user has booked a car", %{car_available: car, user: user} do
      rental_fixture(%{car_id: car.id, user_id: user.id})

      expected_return_date = create_expected_return_date()

      assert {:error, "User has a reservation"} ==
               CreateRental.execute(car.id, expected_return_date, user.id)
    end
  end

  describe "book_car/1" do
    setup do
      car_available = car_fixture(%{available: true})
      car_unavailable = car_fixture(%{available: false})
      user = user_fixture()

      %{car_available: car_available, car_unavailable: car_unavailable, user: user}
    end

    test "book a car", %{car_available: car, user: user} do
      expected_return_date = create_expected_return_date()

      assert Cars.get_car!(car.id).available
      {:ok, result} = CreateRental.execute(car.id, expected_return_date, user.id)
      %{rental: rental, set_car_unavailable: car_updated} = result

      assert car_updated.id == car.id
      refute car_updated.available
      assert rental.end_date == nil
      assert rental.car_id == car.id
      assert rental.user_id == user.id
      assert rental.total == nil
    end
  end

  defp create_expected_return_date do
    NaiveDateTime.utc_now()
    |> then(fn date ->
      case date.month + 1 > 12 do
        true -> %{date | month: 12}
        false -> %{date | month: date.month + 1}
      end
    end)
    |> NaiveDateTime.to_string()
  end

  defp create_expected_return_hour_date do
    NaiveDateTime.utc_now()
    |> then(&%{&1 | hour: &1.hour + 2})
    |> then(fn date ->
      case date.hour + 2 > 23 do
        true -> %{date | hour: 23}
        false -> %{date | hour: date.hour + 2}
      end
    end)
    |> NaiveDateTime.to_string()
  end
end

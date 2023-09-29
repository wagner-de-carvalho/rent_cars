defmodule RentCars.Rentals.CreateRentalsTest do
  use RentCars.DataCase
  import RentCars.CarsFixtures
  alias RentCars.Rentals.CreateRental

  describe "create_rentals/1" do
    test "throws an error when car is not available" do
      car = car_fixture(%{available: false})
      assert {:error, "Car is unavailable"} == CreateRental.execute(car.id)
    end
  end
end

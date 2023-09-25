defmodule RentCars.CarsTest do
  use RentCars.DataCase
  import RentCars.CarsFixtures
  alias RentCars.Cars

  test "create a car with success" do
    payload = car_attrs()

    assert {:ok, car} = Cars.create(payload)
    assert car.name == payload.name
    assert car.description == payload.description
    assert car.brand == payload.brand
    assert car.daily_rate == payload.daily_rate
    assert car.license_plate == String.upcase(payload.license_plate)
    assert car.fine_amount == Money.new(payload.fine_amount)

    Enum.each(car.specifications, fn specification ->
      assert specification.name in Enum.map(payload.specifications, & &1.name)
      assert specification.description in Enum.map(payload.specifications, & &1.description)
    end)
  end

  test "update a car with success" do
    car = car_fixture()

    payload = %{name: "Lancer 2023"}

    assert {:ok, car} = Cars.update(car.id, payload)
    assert car.name == payload.name
  end

  test "throws an exception when trying to update the license_plate" do
    car = car_fixture()

    payload = %{license_plate: "update license_plate"}

    assert {:error, changeset} = Cars.update(car.id, payload)
    assert "you can't update license_plate" in errors_on(changeset).license_plate
  end

  test "list all available cars" do
    Enum.each(1..5, fn number ->
      case number / 2 != 0 do
        true -> car_fixture(%{available: false})
        false -> car_fixture()
      end
    end)

    Cars.list_cars() == "x"
  end
end

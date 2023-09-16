defmodule RentCars.CarsTest do
  use RentCars.DataCase
  alias RentCars.Cars
  import RentCars.CategoriesFixtures

  test "create a car with success" do
    category = category_fixture()

    payload = %{
      name: "Lancer",
      available: true,
      description: "good car",
      brand: "Mitsubishi",
      daily_rate: 100,
      fine_amount: 30,
      license_plate: "ABC1234",
      category_id: category.id,
      specifications: [
        %{name: "Wheels", description: "description"},
        %{name: "Acme", description: "1234"}
      ]
    }

    assert {:ok, car} = Cars.create(payload)
    # assert car.name == "Lancer"
  end
end

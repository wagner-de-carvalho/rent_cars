defmodule RentCars.CarsFixtures do
  import RentCars.CategoriesFixtures
  alias RentCars.Cars

  def car_attrs(attrs \\ %{}) do
    category = category_fixture()

    %{
      name: "Lancer",
      available: true,
      description: "good car",
      brand: "Mitsubishi",
      daily_rate: 100,
      fine_amount: 30,
      license_plate: "ABC#{:rand.uniform(10_000)}",
      category_id: category.id,
      specifications: [
        %{name: "wheels Wheels", description: "description"},
        %{name: "acme", description: "acme description"}
      ]
    }
    |> then(&Enum.into(attrs, &1))
  end

  def car_fixture(attrs \\ %{}) do
    attrs
    |> car_attrs()
    |> Cars.create()
    |> then(&elem(&1, 1))
  end
end

defmodule RentCars.CarsFixtures do
  import RentCars.CategoriesFixtures
  alias RentCars.Cars

  def car_attrs(attrs \\ %{}) do
    category = category_fixture()
    category_id = Map.get(attrs, :category_id) || category.id
    random_tail = :rand.uniform(10_000)

    %{
      name: "Lancer #{random_tail}",
      available: true,
      description: "good car",
      brand: "Mitsubishi",
      daily_rate: 100,
      fine_amount: 30,
      license_plate: "ABC#{random_tail}",
      category_id: category_id,
      specifications: [
        %{name: "wheels #{random_tail}", description: "description"},
        %{name: "acme #{random_tail}", description: "acme description"}
      ]
    }
    |> then(&Enum.into(attrs, &1))
  end

  def car_attrs_string_keys(attrs \\ %{}) do
    category = category_fixture()

    %{
      "name" => "Lancer",
      "available" => true,
      "description" => "good car",
      "brand" => "Mitsubishi",
      "daily_rate" => 100,
      "fine_amount" => 30,
      "license_plate" => "ABC#{:rand.uniform(10_000)}",
      "category" => category,
      "category_id" => category.id
      # "specifications" => [
      #   %{"name" => "wheels Wheels", "description" => "description"},
      #   %{"name" => "acme", "description" => "acme description"}
      # ]
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

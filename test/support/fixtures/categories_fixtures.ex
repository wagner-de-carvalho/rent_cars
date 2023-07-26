defmodule RentCars.CategoriesFixtures do
  alias RentCars.Categories

  def category_fixture(attrs \\ %{}) do
    attrs
    |> Enum.into(%{description: "some description", name: "category name"})
    |> Categories.create_category()
    |> then(fn {:ok, category} -> category end)
  end
end

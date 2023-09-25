defmodule RentCars.CategoriesFixtures do
  alias RentCars.Categories

  def category_fixture(attrs \\ %{}) do
    attrs
    |> Enum.into(%{description: "some description", name: "category name #{random_letters()}"})
    |> Categories.create_category()
    |> then(fn {:ok, category} -> category end)
  end

  defp random_letters(size \\ 5) do
    Stream.map(?a..?z, & &1)
    |> Enum.shuffle()
    |> Enum.take(size)
  end
end

defmodule RentCars.Categories do
  alias __MODULE__.Category
  alias RentCars.Repo

  def list_categories, do: Repo.all(Category)

  def create_category(attrs) do
    attrs
    |> Category.changeset()
    |> Repo.insert()
  end

  def get_category(id), do: Repo.get(Category, id)
end

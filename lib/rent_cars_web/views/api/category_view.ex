defmodule RentCarsWeb.Api.CategoryView do
  use RentCarsWeb, :view

  def render("index.json", %{categories: categories}) do
    %{data: render_many(categories, __MODULE__, "category.json")}
  end

  def render("category.json", %{category: category}) do
    %{id: category.id, description: category.description, name: category.name}
  end
end

defmodule RentCarsWeb.Api.Admin.CarView do
  use RentCarsWeb, :view
  alias RentCarsWeb.Api.Admin.CategoryView
  alias RentCarsWeb.Api.Admin.SpecificationView

  def render("index.json", %{cars: cars}) do
    %{data: render_many(cars, __MODULE__, "car.json")}
  end

  def render("show.json", %{car: car}) do
    %{data: render_one(car, __MODULE__, "car.json")}
  end

  # //TODO melhoria render: transformar em lista -> verificar se é struct -> se for, transformar em mapa -> retornar
  def render("car.json", %{car: car}) do
    %{
      id: car.id,
      description: car.description,
      daily_rate: car.daily_rate,
      license_plate: car.license_plate,
      fine_amount: car.fine_amount,
      category: load_category(car.category),
      specifications: load_specifications(car.specifications),
      name: car.name
    }
  end

  defp load_specifications(specifications) do
    case Ecto.assoc_loaded?(specifications) do
      true ->
        SpecificationView.render("index.json", %{specifications: specifications})

      false ->
        []
    end
  end

  defp load_category(category) do
    case Ecto.assoc_loaded?(category) do
      true ->
        CategoryView.render("category.json", %{category: category})

      false ->
        nil
    end
  end
end

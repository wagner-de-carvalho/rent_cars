defmodule RentCarsWeb.Api.Admin.CarView do
  use RentCarsWeb, :view
  alias RentCars.Cars.CarPhoto
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
      brand: car.brand,
      description: car.description,
      daily_rate: car.daily_rate,
      license_plate: car.license_plate,
      fine_amount: Money.to_string(car.fine_amount),
      category: load_category(car.category),
      specifications: load_specifications(car.specifications),
      images: load_images(car),
      name: car.name
    }
  end

  defp load_specifications(specifications) do
    specifications
    |> Ecto.assoc_loaded?()
    |> then(fn
      true -> SpecificationView.render("index.json", %{specifications: specifications})
      false -> []
    end)
  end

  defp load_category(category) do
    category
    |> Ecto.assoc_loaded?()
    |> then(fn
      true -> CategoryView.render("category.json", %{category: category})
      false -> nil
    end)
  end

  defp load_images(%{images: images} = cars) do
    cars.images
    |> Ecto.assoc_loaded?()
    |> then(fn
      true -> Enum.map(images, &CarPhoto.url({&1.image, &1}, signed: true))
      false -> []
    end)
  end
end

defmodule RentCarsWeb.Api.CarView do
  use RentCarsWeb, :view
  alias RentCars.Cars.CarPhoto
  alias RentCarsWeb.Api.Admin.CategoryView
  alias RentCarsWeb.Api.Admin.SpecificationView

  def render("index.json", %{cars: cars}) do
    %{data: render_many(cars, __MODULE__, "car.json")}
  end

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
      available: car.available,
      name: car.name,
      images: load_images(car)
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

  defp load_images(%{images: images} = cars) do
    case Ecto.assoc_loaded?(cars.images) do
      true ->
        Enum.map(images, &CarPhoto.url({&1.image, &1}))

      false ->
        []
    end
  end
end

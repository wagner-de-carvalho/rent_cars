defmodule RentCars.Cars.CarImage do
  use Ecto.Schema
  import Ecto.Changeset
  import Waffle.Ecto.Schema
  alias RentCars.Cars.CarPhoto

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "car_images" do
    field :image, CarPhoto.Type
    field :car_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(car_image, attrs) do
    car_image
    |> cast(attrs, [:car_id])
    |> cast_attachments(attrs, [:image])
  end
end

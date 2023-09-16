defmodule RentCars.Cars.CarSpecification do
  use Ecto.Schema
  import Ecto.Changeset
  alias RentCars.Cars.Car
  alias RentCars.Specifications.Specification

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "car_specifications" do
    belongs_to :car, Car
    belongs_to :specification, Specification

    timestamps()
  end

  @doc false
  def changeset(attrs), do: changeset(%__MODULE__{}, attrs)

  def changeset(car_specification, attrs) do
    car_specification
    |> cast(attrs, [])
    |> validate_required([])
  end
end

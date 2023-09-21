defmodule RentCars.Cars.Car do
  use Ecto.Schema
  import Ecto.Changeset
  alias RentCars.Cars.CarSpecification
  alias RentCars.Categories.Category
  alias RentCars.Specifications.Specification

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @fields ~w/available brand daily_rate description fine_amount license_plate name category_id/a
  @required @fields

  schema "cars" do
    field :available, :boolean, default: true
    field :brand, :string
    field :daily_rate, :integer
    field :description, :string
    field :fine_amount, :integer
    field :license_plate, :string
    field :name, :string
    belongs_to :category, Category

    many_to_many :specifications, Specification, join_through: CarSpecification

    timestamps()
  end

  @doc false
  def changeset(attrs), do: changeset(%__MODULE__{}, attrs)

  def changeset(car, attrs) do
    car
    |> cast(attrs, @fields)
    |> validate_required(@required)
    |> update_change(:license_plate, &String.upcase/1)
    |> unique_constraint(:license_plate)
    |> cast_assoc(:specifications, with: &Specification.changeset/2)
  end

  def update_changeset(car, attrs) do
    car
    |> changeset(attrs)
    |> validate_change(:license_plate, fn :license_plate, license_plate ->
      case car.license_plate != license_plate do
        true -> [license_plate: "you can't update license_plate"]
        false -> []
      end
    end)
  end
end

defmodule RentCars.Categories.Category do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key :binary_id

  @fields ~w/description name/a

  schema "categories" do
    field :name, :string
    field :description, :string
    timestamps()
  end

  def changeset(attrs \\ %{}), do: changeset(%__MODULE__{}, attrs)

  def changeset(categories, attrs) do
    categories
    |> cast(attrs, @fields)
    |> unique_constraint(:name)
    |> validate_required(@fields)
    |> update_change(:name, &String.upcase/1)
  end
end

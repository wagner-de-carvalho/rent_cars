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

  def changeset(params \\ %{}) do
    changeset(%__MODULE__{}, params)
  end

  def changeset(categories, params) do
    categories
    |> cast(params, @fields)
    |> unique_constraint(:name)
    |> validate_required(@fields)
    |> update_change(:name, &String.upcase/1)
  end
end

defmodule RentCars.Rental do
  use Ecto.Schema
  import Ecto.Changeset

  @fields ~w/start_date end_date expected_return_date total/a
  @required ~w/start_date end_date expected_return_date total/a

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "rentals" do
    field :end_date, :naive_datetime
    field :expected_return_date, :naive_datetime
    field :start_date, :naive_datetime
    field :total, :integer
    field :car_id, :binary_id
    field :user_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(attrs), do: changeset(%__MODULE__{}, attrs)

  def changeset(rental, attrs) do
    rental
    |> cast(attrs, @fields)
    |> validate_required(@required)
  end
end

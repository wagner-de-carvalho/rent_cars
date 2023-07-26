defmodule RentCars.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ecto.Enum

  @role_values ~w/ADMIN USER/a

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key :binary_id

  @fields ~w/role/a
  @required_fields ~w/driver_license first_name email last_name password password_confirmation user_name/a

  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :user_name, :string
    field :email, :string
    field :driver_license, :string
    field :role, Enum, values: @role_values, default: :USER
    field :password_hash, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps()
  end

  def changeset(attrs), do: changeset(%__MODULE__{}, attrs)

  def changeset(user, attrs) do
    user
    |> cast(attrs, @fields ++ @required_fields)
    |> validate_required(@required_fields)
  end
end

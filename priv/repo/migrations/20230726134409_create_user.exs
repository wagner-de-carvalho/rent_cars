defmodule RentCars.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create_query = "CREATE TYPE role AS ENUM('USER', 'ADMIN')"
    drop_query = "DROP TYPE roles"

    execute(create_query, drop_query)

    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :first_name, :string
      add :last_name, :string
      add :user_name, :string
      add :email, :string
      add :driver_license, :string
      add :role, :role, default: "USER", null: false
      add :password_hash, :string

      timestamps()
    end

    create unique_index(:users, [:driver_license, :email, :user_name])
  end
end

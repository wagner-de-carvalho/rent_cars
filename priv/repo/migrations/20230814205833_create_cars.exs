defmodule RentCars.Repo.Migrations.CreateCars do
  use Ecto.Migration

  def change do
    create table(:cars, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :available, :boolean, default: true, null: false
      add :brand, :string
      add :daily_rate, :integer
      add :description, :text
      add :fine_amount, :integer
      add :license_plate, :string
      add :name, :string

      add :category_id,
          references(:categories, on_delete: :delete_all, on_update: :update_all, type: :binary_id)

      timestamps()
    end

    create unique_index(:cars, [:license_plate])
    create index(:cars, [:category_id])
  end
end

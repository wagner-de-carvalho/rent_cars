defmodule RentCars.Repo.Migrations.CreateSpecifications do
  use Ecto.Migration

  def change do
    create table(:specifications, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :description, :text

      timestamps()
    end

    create unique_index(:specifications, [:name])
  end
end

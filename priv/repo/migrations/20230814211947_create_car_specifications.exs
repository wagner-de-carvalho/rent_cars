defmodule RentCars.Repo.Migrations.CreateCarSpecifications do
  use Ecto.Migration

  def change do
    create table(:car_specifications, primary_key: false) do
      add :id, :binary_id, primary_key: true

      add :car_id,
          references(:cars, on_delete: :delete_all, on_update: :update_all, type: :binary_id)

      add :specification_id,
          references(:specifications,
            on_delete: :delete_all,
            on_update: :update_all,
            type: :binary_id
          )

      timestamps()
    end

    create index(:car_specifications, [:car_id])
    create index(:car_specifications, [:specification_id])
  end
end

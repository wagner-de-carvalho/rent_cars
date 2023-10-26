defmodule RentCars.Repo.Migrations.CreateCarImages do
  use Ecto.Migration

  def change do
    create table(:car_images, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:image, :string)

      add(
        :car_id,
        references(:cars, on_delete: :delete_all, on_update: :update_all, type: :binary_id)
      )

      timestamps()
    end

    create(index(:car_images, [:car_id]))
  end
end

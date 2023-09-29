defmodule RentCars.Repo.Migrations.CreateRentals do
  use Ecto.Migration

  def change do
    create table(:rentals, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:start_date, :naive_datetime)
      add(:end_date, :naive_datetime)
      add(:expected_return_date, :naive_datetime)
      add(:total, :integer)

      add(
        :car_id,
        references(:cars, on_delete: :delete_all, on_update: :update_all, type: :binary_id)
      )

      add(
        :user_id,
        references(:users, on_delete: :delete_all, on_update: :update_all, type: :binary_id)
      )

      timestamps()
    end

    create(index(:rentals, [:car_id]))
    create(index(:rentals, [:user_id]))
  end
end

defmodule RentCars.Repo.Migrations.AddUserPhoto do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add(:avatar, :string)
    end
  end
end

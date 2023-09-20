defmodule RentCars.Cars do
  alias RentCars.Cars.Car
  alias RentCars.Repo

  def create(attrs) do
    attrs
    |> Car.changeset()
    |> Repo.insert()
  end
end

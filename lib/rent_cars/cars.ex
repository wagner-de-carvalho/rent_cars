defmodule RentCars.Cars do
  alias RentCars.Cars.Car
  alias RentCars.Repo

  def create(attrs) do
    %Car{}
    |> Car.changeset(attrs)
    |> Repo.insert()
  end
end

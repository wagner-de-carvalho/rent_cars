defmodule RentCars.Cars do
  alias RentCars.Cars.Car
  alias RentCars.Repo

  def create(attrs) do
    attrs
    |> Car.changeset()
    |> Repo.insert()
  end

  def get_car!(car_id), do: Repo.get!(Car, car_id)

  def update(car_id, attrs) do
    car_id
    |> get_car!()
    |> Car.update_changeset(attrs)
    |> Repo.update()
  end
end

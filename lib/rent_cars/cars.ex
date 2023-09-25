defmodule RentCars.Cars do
  import Ecto.Query
  alias RentCars.Cars.Car
  alias RentCars.Repo

  def create(attrs) do
    attrs
    |> Car.changeset()
    |> Repo.insert()
  end

  def get_car!(car_id) do
    Car
    |> Repo.get!(car_id)
    |> Repo.preload([:specifications])
  end

  def list_cars do
    Car
    |> where([c], c.available == true)
    |> preload([:specifications])
    |> Repo.all()
  end

  def update(car_id, attrs) do
    car_id
    |> get_car!()
    |> Car.update_changeset(attrs)
    |> Repo.update()
  end
end

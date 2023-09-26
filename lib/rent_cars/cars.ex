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

  def list_cars(filter_params \\ []) do
    query = where(Car, [c], c.available == true)

    filter_params
    |> Enum.reduce(query, fn
      {:name, name}, query ->
        name = "%" <> name <> "%"
        where(query, [c], ilike(c.name, ^name))

      {:brand, brand}, query ->
        brand = "%" <> brand <> "%"
        where(query, [c], ilike(c.brand, ^brand))

      {:category, category}, query ->
        category = "%" <> category <> "%"

        query
        |> join(:inner, [c], ca in assoc(c, :category))
        |> where([_c, ca], ilike(ca.name, ^category))
    end)
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

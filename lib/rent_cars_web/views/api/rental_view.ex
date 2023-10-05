defmodule RentCarsWeb.Api.RentalView do
  use RentCarsWeb, :view
  alias RentCars.Repo
  alias RentCarsWeb.Api.Admin.CarView

  def render("show.json", %{rental: rental}) do
    %{data: render_one(rental, __MODULE__, "rental.json")}
  end

  def render("rental.json", %{rental: rental}) do
    %{
      id: rental.id,
      expected_return_date: rental.expected_return_date,
      end_date: rental.end_date,
      total: rental.total,
      car_id: rental.car_id,
      car: load_car(rental),
      user_id: rental.user_id
    }
  end

  defp load_car(%{car: car} = rental) do
    if Ecto.assoc_loaded?(car) do
      CarView.render("show.json", %{car: car})
    else
      rental = Repo.preload(rental, [:car])
      CarView.render("show.json", %{car: rental.car})
    end
  end
end

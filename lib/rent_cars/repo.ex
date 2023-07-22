defmodule RentCars.Repo do
  use Ecto.Repo,
    otp_app: :rent_cars,
    adapter: Ecto.Adapters.Postgres
end

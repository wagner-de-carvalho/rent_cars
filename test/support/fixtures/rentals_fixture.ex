defmodule RentCars.RentalsFixtures do
  alias RentCars.Rentals.Rental
  alias RentCars.Repo

  def rental_fixture(attrs \\ %{}) do
    expected_return_date = then(NaiveDateTime.utc_now(), &%{&1 | month: &1.month + 1})

    attrs =
      Enum.into(attrs, %{
        expected_return_date: expected_return_date,
        start_date: NaiveDateTime.utc_now()
      })

    changeset = Rental.changeset(attrs)

    changeset
    |> Repo.insert()
    |> elem(1)
  end
end

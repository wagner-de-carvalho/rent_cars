defmodule RentCars.Shared.DateValidations do
  def check_if_is_more_than_24(date_param) do
    now = NaiveDateTime.utc_now()
    error = {:error, "Invalid return date"}

    date_param
    |> NaiveDateTime.from_iso8601!()
    |> Timex.diff(now, :days)
    |> then(&(&1 > 0 || error))
  end
end

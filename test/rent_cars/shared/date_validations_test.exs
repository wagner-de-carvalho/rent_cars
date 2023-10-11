defmodule RentCars.Shared.DateValidationsTest do
  use RentCars.DataCase
  alias RentCars.Shared.DateValidations

  describe "check_if_is_more_than_24/1" do
    test "throws an error if date is less than 24 hours" do
      end_date = create_expected_return_hour_date()

      expected_response = {:error, "Invalid return date"}
      result = DateValidations.check_if_is_more_than_24(end_date)
      assert result == expected_response
    end

    test "returns true if date is more than 24 hours" do
      end_date =
        NaiveDateTime.utc_now()
        |> then(&%{&1 | month: &1.month + 1})
        |> NaiveDateTime.to_string()

      assert DateValidations.check_if_is_more_than_24(end_date)
    end

    defp create_expected_return_hour_date do
      NaiveDateTime.utc_now()
      |> then(&%{&1 | hour: &1.hour + 2})
      |> then(fn date ->
        case date.hour + 2 > 23 do
          true -> %{date | hour: 23}
          false -> %{date | hour: date.hour + 2}
        end
      end)
      |> NaiveDateTime.to_string()
    end
  end
end

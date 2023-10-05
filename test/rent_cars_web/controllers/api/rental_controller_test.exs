defmodule RentCarsWeb.Api.RentalControllerTest do
  use RentCarsWeb.ConnCase
  import RentCars.CarsFixtures

  describe "create/2" do
    setup :include_normal_user_token

    test "create rental", %{conn: conn} do
      car = car_fixture()

      payload = %{
        car_id: car.id,
        expected_return_date: create_expected_return_date()
      }

      conn = post(conn, Routes.api_rental_path(conn, :create, payload))

      assert json_response(conn, 201)["data"]["car_id"] == car.id
    end
  end

  defp create_expected_return_date do
    NaiveDateTime.utc_now()
    |> then(&%{&1 | month: &1.month + 1})
    |> NaiveDateTime.to_string()
  end
end

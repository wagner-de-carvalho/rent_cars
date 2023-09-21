defmodule RentCarsWeb.Api.Admin.CarControllerTest do
  use RentCarsWeb.ConnCase
  import RentCars.CarsFixtures

  setup :include_admin_token

  describe "create/2" do
    test "create car when data are valid", %{conn: conn} do
      payload = car_attrs_string_keys()
      conn = post(conn, Routes.api_admin_car_path(conn, :create, payload))

      assert %{"id" => _id} = json_response(conn, 201)["data"]
    end
  end

  describe "update/2" do
    test "updates a car when data are valid", %{conn: conn} do
      car = car_fixture()

      payload = %{name: "Cobalt", daily_rate: 172}

      conn = put(conn, Routes.api_admin_car_path(conn, :update, car), payload)
      response = json_response(conn, 200)["data"]
      assert %{"id" => _id} = response

      assert payload.name == response["name"]
      assert payload.daily_rate == response["daily_rate"]
    end
  end
end

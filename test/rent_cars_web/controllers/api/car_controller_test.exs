defmodule RentCarsWeb.Api.CarControllerTest do
  use RentCarsWeb.ConnCase
  import RentCars.CarsFixtures

  describe "index/2" do
    test "list all available cars", %{conn: conn} do
      car_fixture(%{brand: "acme"})
      car_fixture()

      conn = get(conn, Routes.api_car_path(conn, :index))
      response = json_response(conn, 200)["data"]

      assert response |> Enum.count() > 0
      assert hd(response)["daily_rate"] == 100
      assert hd(response)["brand"] == "acme"
    end
  end
end

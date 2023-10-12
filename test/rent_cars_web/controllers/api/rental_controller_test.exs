defmodule RentCarsWeb.Api.RentalControllerTest do
  use RentCarsWeb.ConnCase
  import RentCars.CarsFixtures
  import RentCars.RentalsFixtures

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

  describe "index/2" do
    setup :include_normal_user_token

    test "create rental", %{conn: conn, user: user} do
      car = car_fixture()
      rental_fixture(%{user_id: user.id, car_id: car.id})

      conn = get(conn, Routes.api_rental_path(conn, :index))
      response = json_response(conn, 200)["data"]
      rental = hd(response)

      assert response |> Enum.count() >= 0
      assert rental["car"]["data"]["id"] == car.id
    end
  end

  describe "return_car/2" do
    setup :include_normal_user_token

    test "return car", %{conn: conn, user: user} do
      car = car_fixture()
      rental = rental_fixture(%{user_id: user.id, car_id: car.id})

      conn = post(conn, Routes.api_rental_path(conn, :return, rental))

      car_id = car.id

      response = json_response(conn, 201)["data"]

      assert %{"car" => %{"data" => %{"id" => ^car_id}}} = response
    end
  end

  defp create_expected_return_date do
    NaiveDateTime.utc_now()
    |> then(&%{&1 | month: &1.month + 1})
    |> NaiveDateTime.to_string()
  end
end

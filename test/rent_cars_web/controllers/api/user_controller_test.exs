defmodule RentCarsWeb.Api.UserControllerTest do
  use RentCarsWeb.ConnCase
  import RentCars.AccountsFixtures

  test "create user when data is valid", %{conn: conn} do
    attrs = user_attrs()
    conn = post(conn, Routes.api_user_path(conn, :create, attrs))

    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get(conn, Routes.api_user_path(conn, :show, id))

    email = attrs.email

    assert %{"id" => ^id, "email" => ^email} = json_response(conn, 200)["data"]
  end
end

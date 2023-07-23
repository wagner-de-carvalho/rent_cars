defmodule RentCarsWeb.Api.CategoryControllerTest do
  use RentCarsWeb.ConnCase

  test "list all categories", %{conn: conn} do
    conn = get(conn, Routes.api_category_path(conn, :index))

    assert json_response(conn, 200)["data"] == [
             %{
               "id" => "123",
               "description" => "acme 123",
               "name" => "SPORT"
             }
           ]
  end
end

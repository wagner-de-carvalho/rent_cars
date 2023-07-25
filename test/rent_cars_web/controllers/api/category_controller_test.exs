defmodule RentCarsWeb.Api.CategoryControllerTest do
  use RentCarsWeb.ConnCase

  test "list all categories", %{conn: conn} do
    conn = get(conn, Routes.api_category_path(conn, :index))

    assert json_response(conn, 200)["data"] == []
  end

  test "create category when data is valid", %{conn: conn} do
    attrs = %{description: "sport", name: "Acme test"}
    conn = post(conn, Routes.api_category_path(conn, :create, attrs))

    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get(conn, Routes.api_category_path(conn, :show, id))

    name = String.upcase(attrs.name)
    description = attrs.description

    assert %{"id" => ^id, "name" => ^name, "description" => ^description} =
             json_response(conn, 200)["data"]
  end

  test "try to create category when data is invalid", %{conn: conn} do
    attrs = %{name: "Acme test"}
    conn = post(conn, Routes.api_category_path(conn, :create, attrs))

    assert json_response(conn, 422)["errors"] == %{"description" => ["can't be blank"]}
  end
end

defmodule RentCarsWeb.Api.CategoryControllerTest do
  use RentCarsWeb.ConnCase
  import RentCars.CategoriesFixtures

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

  describe "update_category/2" do
    setup [:create_category]

    test "update category with valid data", %{conn: conn, category: category} do
      conn =
        put(conn, Routes.api_category_path(conn, :update, category), %{name: "update category"})

      assert %{"id" => id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.api_category_path(conn, :show, id))

      json_response(conn, 200)["data"]

      name = String.upcase("update category")

      assert %{
               "id" => ^id,
               "name" => ^name
             } = json_response(conn, 200)["data"]
    end
  end

  describe "delete_category/1" do
    setup [:create_category]

    test "delete category", %{conn: conn, category: category} do
      id = category.id
      conn = delete(conn, Routes.api_category_path(conn, :delete, category))

      assert response(conn, 204)

      assert_error_sent 404, fn -> get(conn, Routes.api_category_path(conn, :show, id)) end
    end
  end

  defp create_category(_) do
    category = category_fixture()
    %{category: category}
  end
end

defmodule RentCarsWeb.Api.UserControllerTest do
  use RentCarsWeb.ConnCase
  import RentCars.AccountsFixtures

  setup :include_normal_user_token

  test "create user when data is valid", %{conn: conn} do
    attrs = user_attrs()
    conn = post(conn, Routes.api_user_path(conn, :create, attrs))

    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get(conn, Routes.api_user_path(conn, :show, id))

    email = attrs.email

    assert %{"id" => ^id, "email" => ^email} = json_response(conn, 200)["data"]
  end

  test "upload user image", %{conn: conn} do
    photo = %Plug.Upload{
      content_type: "image/png",
      filename: "avatar.png",
      path: "test/support/fixtures/avatar.png"
    }

    conn = patch(conn, Routes.api_user_path(conn, :upload_photo), avatar: photo)

    assert json_response(conn, 201)["data"]["avatar"] |> String.contains?("avatar.png")
  end
end

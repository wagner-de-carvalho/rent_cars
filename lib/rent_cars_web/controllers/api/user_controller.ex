defmodule RentCarsWeb.Api.UserController do
  use RentCarsWeb, :controller
  alias RentCars.Accounts
  alias RentCarsWeb.FallbackController

  action_fallback FallbackController

  def create(conn, attrs) do
    with {:ok, user} <- Accounts.create_user(attrs) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.api_user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def index(conn, _params) do
    with users <- Accounts.list_users() do
      conn
      |> put_status(:ok)
      |> render("index.json", users: users)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    conn
    |> put_status(:ok)
    |> render("show.json", user: user)
  end

  def upload_photo(conn, %{"avatar" => avatar}) do
    [user_id] = get_req_header(conn, "user_id")

    with {:ok, user} <- Accounts.upload_photo(user_id, avatar) do
      conn
      |> put_status(:created)
      |> render("show.json", user: user)
    end
  end
end

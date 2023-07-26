defmodule RentCarsWeb.Api.AccountController do
  use RentCarsWeb, :controller
  alias RentCarsWeb.FallbackController
  alias RentCars.Accounts

  action_fallback FallbackController

  def index(conn, _params) do
    with users <- Accounts.list_users() do
      conn
      |> put_status(:ok)
      |> render("index.json", accounts: users)
    end
  end

  def create(conn, attrs) do
    with {:ok, user} <- Accounts.create_user(attrs) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.api_account_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    conn
    |> put_status(:ok)
    |> render("show.json", user: user)
  end
end

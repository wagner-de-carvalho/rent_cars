defmodule RentCarsWeb.Api.SessionController do
  use RentCarsWeb, :controller
  alias RentCars.Accounts.User
  alias RentCars.Sessions
  alias RentCarsWeb.FallbackController

  action_fallback FallbackController

  def create(conn, %{"email" => email, "password" => password} = _params) do
    with {:ok, %User{} = user, token} <- Sessions.create(email, password) do
      session = %{user: user, token: token}

      conn
      |> put_status(:created)
      |> render("show.json", session: session)
    end
  end

  def me(conn, %{"token" => token} = _params) do
    with {:ok, %User{} = user} <- Sessions.me(token) do
      session = %{user: user, token: token}

      conn
      |> put_status(:ok)
      |> render("show.json", session: session)
    end
  end
end
defmodule RentCarsWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.
  """
  use RentCarsWeb, :controller
  alias Ecto.Changeset
  alias RentCarsWeb.ChangesetView
  alias RentCarsWeb.ErrorView

  # This clause handles errors returned by Ecto's insert/update/delete.
  def call(conn, {:error, %Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(ChangesetView)
    |> render("error.json", changeset: changeset)
  end

  # This clause is an example of how to handle resources that cannot be found.
  def call(conn, {:error, message}) when is_bitstring(message) do
    conn
    |> put_status(:not_found)
    |> put_view(ErrorView)
    |> render("404.json", error: message)
  end

  # This clause is an example of how to handle resources that cannot be found.
  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(ErrorView)
    |> render(:"404")
  end
end

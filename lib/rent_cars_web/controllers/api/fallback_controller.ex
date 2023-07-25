defmodule RentCarsWeb.Api.FallbackController do
  use RentCarsWeb, :controller
  alias Ecto.Changeset
  alias RentCarsWeb.ChangesetView

  def call(conn, {:error, %Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(ChangesetView)
    |> render("error.json", changeset: changeset)
  end
end

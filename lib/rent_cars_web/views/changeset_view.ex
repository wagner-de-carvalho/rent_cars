defmodule RentCarsWeb.ChangesetView do
  use RentCarsWeb, :view
  alias Ecto.Changeset

  def render("error.json", %{changeset: changeset}) do
    %{errors: Changeset.traverse_errors(changeset, &translate_error/1)}
  end
end

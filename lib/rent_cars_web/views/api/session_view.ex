defmodule RentCarsWeb.Api.SessionView do
  use RentCarsWeb, :view
  alias RentCarsWeb.Api.UserView

  def render("show.json", %{session: session}) do
    %{data: render_one(session, __MODULE__, "session.json")}
  end

  def render("session.json", %{session: session}) do
    %{
      token: session.token,
      user: UserView.render("show.json", user: session.user)
    }
  end
end

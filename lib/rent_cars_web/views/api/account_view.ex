defmodule RentCarsWeb.Api.AccountView do
  use RentCarsWeb, :view

  def render("show.json", %{user: user}) do
    %{data: render_one(user, __MODULE__, "user.json")}
  end

  def render("user.json", %{account: user}) do
    %{
      id: user.id,
      user_name: user.user_name,
      email: user.email,
      role: user.role,
      last_name: user.last_name,
      first_name: user.first_name,
      driver_license: user.driver_license
    }
  end

  def render("index.json", %{accounts: accounts}) do
    %{data: render_many(accounts, __MODULE__, "user.json")}
  end
end

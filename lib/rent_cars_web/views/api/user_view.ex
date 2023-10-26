defmodule RentCarsWeb.Api.UserView do
  use RentCarsWeb, :view
  alias RentCars.Accounts.Avatar

  def render("show.json", %{user: user}) do
    %{data: render_one(user, __MODULE__, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      user_name: user.user_name,
      email: user.email,
      role: user.role,
      avatar: Avatar.url({user.avatar, user}, signed: true),
      last_name: user.last_name,
      first_name: user.first_name,
      driver_license: user.driver_license
    }
  end

  def render("index.json", %{users: users}) do
    %{data: render_many(users, __MODULE__, "user.json")}
  end
end

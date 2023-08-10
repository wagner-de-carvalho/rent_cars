defmodule RentCars.AccountsFixtures do
  alias RentCars.Accounts

  def user_attrs(attrs \\ %{}) do
    random_letters = Enum.shuffle(?a..?z) |> Enum.take(5)
    random_driver_license = Enum.shuffle(0..9) |> Enum.take(6) |> Enum.join("")

    %{
      first_name: "acme",
      last_name: "foo",
      user_name: "#{random_letters}acme",
      email: "#{random_letters}acme@mail.com",
      driver_license: random_driver_license,
      password: "123456",
      password_confirmation: "123456",
      role: "USER"
    }
    |> then(&Enum.into(attrs, &1))
  end

  def user_fixture(attrs \\ %{}) do
    attrs
    |> user_attrs()
    |> Accounts.create_user()
    |> then(fn {:ok, user} -> user end)
  end

  def admin_fixture(attrs \\ %{}) do
    attrs
    |> user_attrs()
    |> Map.put(:role, "ADMIN")
    |> Accounts.create_user()
    |> then(fn {:ok, user} -> user end)
  end
end

defmodule RentCars.AccountsFixtures do
  alias RentCars.Accounts

  def user_attrs(attrs \\ %{}) do
    %{
      first_name: "acme",
      last_name: "foo",
      user_name: "acme",
      email: "acme@mail.com",
      driver_license: "123456",
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

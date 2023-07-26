defmodule RentCars.AccountsTest do
  use RentCars.DataCase
  alias RentCars.Accounts

  setup do
    valid_attrs = %{
      first_name: "acme",
      last_name: "foo",
      user_name: "acme",
      email: "acme@mail.com",
      driver_license: "123456",
      password: "password",
      password_confirmation: "password",
      role: "USER"
    }

    %{valid_attrs: valid_attrs}
  end

  describe "create users" do
    test "create user with valid data", %{valid_attrs: valid_attrs} do
      assert {:ok, user} = Accounts.create_user(valid_attrs)
      assert user.first_name === valid_attrs.first_name
      assert user.last_name === valid_attrs.last_name
      assert user.user_name === valid_attrs.user_name
      assert user.email === valid_attrs.email
      assert user.driver_license === valid_attrs.driver_license
    end
  end
end

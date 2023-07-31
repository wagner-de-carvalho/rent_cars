defmodule RentCars.AccountsTest do
  use RentCars.DataCase
  alias RentCars.Accounts
  import RentCars.AccountsFixtures

  setup do
    valid_attrs = %{
      first_name: "acme",
      last_name: "foo",
      user_name: "acme",
      email: "acme@mail.com",
      driver_license: "123456",
      password: "123456",
      password_confirmation: "123456",
      role: "USER"
    }

    %{valid_attrs: valid_attrs}
  end

  describe "get_user!/1" do
    test "get user" do
      user = user_fixture()

      assert Accounts.get_user!(user.id).email == user.email
    end
  end

  describe "create users" do
    test "create user with valid data", %{valid_attrs: valid_attrs} do
      assert {:ok, user} = Accounts.create_user(valid_attrs)
      assert user.first_name === valid_attrs.first_name
      assert user.last_name === valid_attrs.last_name
      assert user.user_name === valid_attrs.user_name
      assert user.email === String.downcase(valid_attrs.email)
      assert user.driver_license === valid_attrs.driver_license
    end

    test "throw an error when e-mail is invalid", %{valid_attrs: valid_attrs} do
      invalid_attrs = Map.put(valid_attrs, :email, "invalid_email")
      assert {:error, changeset} = Accounts.create_user(invalid_attrs)
      assert "type a valid e-mail" in errors_on(changeset).email
    end

    test "throw an error when password is invalid", %{valid_attrs: valid_attrs} do
      invalid_attrs = Map.put(valid_attrs, :password, "12345")
      assert {:error, changeset} = Accounts.create_user(invalid_attrs)
      assert "should be at least 6 character(s)" in errors_on(changeset).password
    end

    test "throw an error when password confirmation does not match", %{valid_attrs: valid_attrs} do
      invalid_attrs = Map.put(valid_attrs, :password_confirmation, "12345")
      assert {:error, changeset} = Accounts.create_user(invalid_attrs)
      assert "does not match confirmation" in errors_on(changeset).password_confirmation
    end

    test "throw an error when unique fields are repeated", %{valid_attrs: valid_attrs} do
      assert {:ok, _user} = Accounts.create_user(valid_attrs)
      assert {:error, changeset} = Accounts.create_user(valid_attrs)
      assert "has already been taken" in errors_on(changeset).driver_license
    end
  end
end

defmodule RentCars.SessionsTest do
  use RentCars.DataCase
  import RentCars.AccountsFixtures
  alias RentCars.Sessions

  describe "create/2" do
    test "return authenticated user" do
      user = user_fixture()
      password = "123456"

      assert {:ok, user_return, _token} = Sessions.create(user.email, password)
      assert user.email == user_return.email
    end

    test "throw error when password is incorrect" do
      user = user_fixture()
      password = "incorrect_password"

      assert {:error, message} = Sessions.create(user.email, password)
      assert "E-mail or password is incorrect" == message
    end

    test "throw error when e-mail is incorrect" do
      password = "incorrect_password"
      email = "incorrect@mail.com"

      assert {:error, message} = Sessions.create(email, password)
      assert "E-mail or password is incorrect" == message
    end
  end
end

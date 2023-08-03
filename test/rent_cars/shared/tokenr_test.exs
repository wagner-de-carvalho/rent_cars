defmodule RentCars.Shared.TokenrTest do
  use RentCars.DataCase
  import RentCars.AccountsFixtures
  alias RentCars.Shared.Tokenr

  describe "generate_auth_token/1" do
    test "create auth token" do
      user = user_fixture()
      token = Tokenr.generate_auth_token(user)

      assert {:ok, user_return} = Tokenr.verify_auth_token(token)
      assert user == user_return
    end

    test "create forgot e-mail token" do
      user = user_fixture()
      token = Tokenr.generate_forgot_email_token(user)

      assert {:ok, user_return} = Tokenr.verify_forgot_email_token(token)
      assert user == user_return
    end
  end
end

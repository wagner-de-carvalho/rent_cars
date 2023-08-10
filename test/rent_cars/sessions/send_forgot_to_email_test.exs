defmodule RentCars.Sessions.SendForgotToEmailTest do
  use RentCars.DataCase
  import RentCars.AccountsFixtures
  alias RentCars.Sessions.SendForgotToEmail

  test "send e-mail to reset password" do
    user = user_fixture()

    assert {:ok, user_return, _token} = SendForgotToEmail.execute(user.email)
    assert user.email == user_return.email
  end

  test "throw an error when user does not exist" do
    incorrect_email = "incorrect_email@mail.com"
    assert {:error, message} = SendForgotToEmail.execute(incorrect_email)
    assert "User does not exist" == message
  end
end

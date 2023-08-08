defmodule RentCars.Mail.ForgotPasswordEmailTest do
  use RentCars.DataCase
  import RentCars.AccountsFixtures
  alias RentCars.Mail.ForgotPasswordEmail

  test "send e-mail to reset password" do
    user = user_fixture()
    user = %{user | email: "wagndevcarv@gmail.com"}
    token = "randdom00ytoken00"
    email_expected = ForgotPasswordEmail.create_email(user, token)
    assert email_expected.to == [{user.first_name, user.email}]
  end
end

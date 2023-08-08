defmodule RentCars.Sessions.SendForgotToEmail do
  alias RentCars.Accounts.User
  alias RentCars.Mail.ForgotPasswordEmail
  alias RentCars.Repo
  alias RentCars.Shared.Tokenr

  def execute(email) do
    User
    |> Repo.get_by(email: email)
    |> prepare_response()
  end

  defp prepare_response(nil), do: {:error, "User does not exist"}

  defp prepare_response(user) do
    user
    |> Tokenr.generate_forgot_email_token()
    |> tap(&ForgotPasswordEmail.send_forgot_password_email(user, &1))
    |> then(&{:ok, user, &1})

    # token = Tokenr.generate_forgot_email_token(user)
    # ForgotPasswordEmail.send_forgot_password_email(user, token)
    # {:ok, user, token}
  end
end

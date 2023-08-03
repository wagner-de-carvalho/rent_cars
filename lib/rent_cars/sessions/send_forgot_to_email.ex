defmodule RentCars.Sessions.SendForgotToEmail do
  alias RentCars.Accounts.User
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
    |> then(fn token -> {:ok, user, token} end)
  end
end

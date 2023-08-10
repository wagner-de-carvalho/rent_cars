defmodule RentCars.Sessions.ResetPassword do
  alias RentCars.Accounts
  alias RentCars.Shared.Tokenr

  def execute(params) do
    params
    |> Map.get("token")
    |> Tokenr.verify_forgot_email_token()
    |> perform(params)
  end

  def perform({:error, :expired}, _params), do: {:error, "Invalid token"}
  def perform({:error, :missing}, _params), do: {:error, "Invalid token"}

  def perform({:ok, user}, params) do
    Accounts.update_user(user, params)
  end
end

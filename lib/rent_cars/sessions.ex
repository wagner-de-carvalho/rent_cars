defmodule RentCars.Sessions do
  alias RentCars.Accounts.User
  alias RentCars.Repo
  alias RentCars.Shared.Tokenr

  @invalid_credentials_error {:error, "E-mail or password is incorrect"}

  def create(email, password) do
    User
    |> Repo.get_by(email: email)
    |> check_user_exist()
    |> validate_password(password)
  end

  defp check_user_exist(nil), do: @invalid_credentials_error

  defp check_user_exist(%User{} = user), do: user

  defp validate_password({:error, _} = error, _), do: error

  defp validate_password(user, password) do
    if Argon2.verify_pass(password, user.password_hash) do
      token = Tokenr.generate_auth_token(user)
      {:ok, user, token}
    else
      @invalid_credentials_error
    end
  end
end

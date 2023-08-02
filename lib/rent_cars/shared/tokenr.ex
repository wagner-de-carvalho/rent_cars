defmodule RentCars.Shared.Tokenr do
  alias Phoenix.Token
  @context RentCarsWeb.Endpoint
  @login_token_salt "exqoTfLa6AeeF05LGgb9WHUJZTxHGM4JrdcGFLGy1wDs5BlF8lsehZLCIiLtb4US"
  @max_age 86_400

  def generate_auth_token(user) do
    Token.sign(@context, @login_token_salt, user)
  end

  def verify_auth_token(token) do
    Token.verify(@context, @login_token_salt, token, max_age: @max_age)
  end
end

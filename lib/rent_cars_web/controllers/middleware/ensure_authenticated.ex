defmodule RentCarsWeb.Middleware.EnsureAuthenticated do
  import Plug.Conn
  alias RentCars.Shared.Tokenr

  def init(options), do: options

  def call(conn, _options) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, user} <- Tokenr.verify_auth_token(token) do
      put_req_header(conn, "user_id", user.id)
    else
      _ ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(403, Jason.encode!(%{error: "Unauthenticated/Invalid token"}))
        |> halt()
    end
  end
end

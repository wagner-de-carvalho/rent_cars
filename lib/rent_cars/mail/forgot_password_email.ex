defmodule RentCars.Mail.ForgotPasswordEmail do
  @view RentCarsWeb.EmailView
  use Phoenix.Swoosh, view: @view, layout: {@view, :layout}
  import Swoosh.Email
  alias RentCars.Mailer

  @url "/sessions/rest_password"

  def create_email(user, token) do
    url = "#{@url}?token=#{token}"

    new()
    |> to({user.first_name, user.email})
    |> from({"RentCars", "wagndevcarv@gmail.com"})
    |> subject("RentCars - Reset Password")
    |> render_body("forgot_password.html", %{first_name: user.first_name, url: url})
  end

  def send_forgot_password_email(user, token) do
    Task.async(fn ->
      user
      |> create_email(token)
      |> Mailer.deliver()
    end)
  end
end

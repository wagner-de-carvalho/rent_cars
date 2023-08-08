defmodule RentCars.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false
  alias Swoosh.ApiClient.Finch

  use Application

  @impl true
  def start(_type, _args) do
    unless Mix.env() == :prod do
      Dotenv.load()
      Mix.Task.run("loadconfig")
    end

    children = [
      # Start the Ecto repository
      RentCars.Repo,
      # Start the Telemetry supervisor
      RentCarsWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: RentCars.PubSub},
      # Start the Endpoint (http/https)
      RentCarsWeb.Endpoint,
      # Start a worker by calling: RentCars.Worker.start_link(arg)
      # {RentCars.Worker, arg}
      #{Finch, name: Swoosh.Finch}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: RentCars.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    RentCarsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

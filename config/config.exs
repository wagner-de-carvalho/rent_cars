# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :rent_cars,
  ecto_repos: [RentCars.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :rent_cars, RentCarsWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: RentCarsWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: RentCars.PubSub,
  live_view: [signing_salt: "Ik1Eo9wI"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :rent_cars, RentCars.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.29",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Money Library
config :money,
  default_currency: :USD

# Waffle Local
# config :waffle,
#   storage: Waffle.Storage.Local

# Waffle AWS S3 Bucket
config :waffle,
  storage: Waffle.Storage.S3,
  bucket: System.fetch_env!("AWS_S3_BUCKET")

config :ex_aws,
json_codec: Jason,
access_key_id: System.fetch_env!("AWS_ACCESS_KEY_ID"),
secret_access_key: System.fetch_env!("SECRET_ACCESS_KEY"),
region: System.fetch_env!("AWS_REGION")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config("#{config_env()}.exs")

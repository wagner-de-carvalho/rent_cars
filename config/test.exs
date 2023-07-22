import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :rent_cars, RentCars.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "rent_cars_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :rent_cars, RentCarsWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "b/rWF8jTArTz+RUc9g68NMDk6Gew1++1jB0mykucmoOx2bcl5stykRl8d1drUHgC",
  server: false

# In test we don't send emails.
config :rent_cars, RentCars.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

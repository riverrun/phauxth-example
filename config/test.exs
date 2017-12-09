use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :forks_the_egg_sample, ForksTheEggSampleWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :forks_the_egg_sample, ForksTheEggSample.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "forks_the_egg_sample_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# Comeonin password hashing test config
#config :argon2_elixir,
  #t_cost: 2,
  #m_cost: 8
config :bcrypt_elixir, log_rounds: 4
#config :pbkdf2_elixir, rounds: 1

# Configures mailer for testing
config :forks_the_egg_sample, ForksTheEggSample.Mailer,
  adapter: Bamboo.TestAdapter

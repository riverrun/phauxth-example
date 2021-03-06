# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :forks_the_egg_sample,
  ecto_repos: [ForksTheEggSample.Repo]

# Configures the endpoint
config :forks_the_egg_sample, ForksTheEggSampleWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "VGy/YPnKoEHa7NXTHxKGrn4rIaejhpcvOws9CFMrQ6dAWpX8CfnFmOswybqcESQJ",
  render_errors: [view: ForksTheEggSampleWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ForksTheEggSample.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Phauxth authentication
config :phauxth,
  user_context: ForksTheEggSample.Accounts,
  token_module: ForksTheEggSampleWeb.Auth.Token

config :argon2_elixir, t_cost: 2, m_cost: 8

# Configures mailer
config :forks_the_egg_sample, ForksTheEggSampleWeb.Mailer, adapter: Bamboo.LocalAdapter

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

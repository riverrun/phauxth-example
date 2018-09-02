# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :forks_the_egg_sample,
  ecto_repos: [ForksTheEggSample.Repo]

# Configures the endpoint
config :forks_the_egg_sample, ForksTheEggSampleWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "FI2QwafXZvEtIRDHk8zaOq90HVy0LAuQLQLkM6FgE5Oru005k+SXk2g+8iTVEM3p",
  render_errors: [view: ForksTheEggSampleWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ForksTheEggSample.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Phauxth authentication
config :phauxth,
  token_salt: "yX7/DDXv",
  endpoint: ForksTheEggSampleWeb.Endpoint

# Configures mailer
config :forks_the_egg_sample, ForksTheEggSample.Mailer, adapter: Bamboo.LocalAdapter

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix and Ecto
config :phoenix, :json_library, Jason
config :ecto, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

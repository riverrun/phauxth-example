use Mix.Config

# In this file, we keep production configuration that
# you'll likely want to automate and keep away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or yourself later on).
config :forks_the_egg_sample, ForksTheEggSampleWeb.Endpoint,
  secret_key_base: "87nhtnteOGW9KpnES9cB4uk17CoJHmpY1TaarrWFBsr8C6v2IE1RmvMb10WWBk3L"

# Configure your database
config :forks_the_egg_sample, ForksTheEggSample.Repo,
  username: "postgres",
  password: "postgres",
  database: "forks_the_egg_sample_prod",
  pool_size: 15

defmodule ForksTheEggSample.Repo do
  use Ecto.Repo,
    otp_app: :forks_the_egg_sample,
    adapter: Ecto.Adapters.Postgres
end

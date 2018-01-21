# Phauxth authentication example Phoenix app

An example Phoenix app using the [Phauxth authentication library](https://github.com/riverrun/phauxth).

You can clone this repository and use the app as it is, or you can generate
it using the [Phauxth installer](https://github.com/riverrun/phauxth_installer).

## Cloning this repo and using the app

1. Run the following commands:

```elixir
git clone https://github.com/riverrun/phauxth-example.git
cd phauxth-example
```

2. Get dependencies:

```elixir
mix deps.get
```

3. Build the javascript assets:

```
(cd assets && npm install && node node_modules/brunch/bin/brunch build)
```

4. Set up the database:

```elixir
mix ecto.setup
```

5. Set up the bamboo email library (see below)

## Using the Phauxth installer

1. Install the Phauxth installer and run `phauxth.new`:

```elixir
mix archive.install https://github.com/riverrun/phauxth_installer/raw/master/archives/phauxth_new.ez
mix phx.new forks_the_egg_sample # or any other suitable app name
cd forks_the_egg_sample
mix phauxth.new --confirm --remember --no-backups
```

2. Get dependencies:

```elixir
mix deps.get
```

3. Set up the database:

```elixir
mix ecto.setup
```

4. Set up the bamboo email library (see below)

## Setting up bamboo email library

The bamboo email library is configured in the `config/config.exs`, using
the LocalAdapter, and `config/test.exs`, using the TestAdapter, files.

The LocalAdapter is great for development, but to actually send emails to
users, you will need to setup a different adapter. For more information
about the available adapters, see the [bamboo README](https://github.com/thoughtbot/bamboo).

## Useful commands

* To start your Phoenix server, run `mix phx.server` or `iex -S mix phx.server`
  * you can now visit [`localhost:4000`](http://localhost:4000) from your browser
* To run tests, run `mix test`
* To reset the database, run `mix ecto.reset`

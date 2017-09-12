# Phauxth authentication example Phoenix app

An example Phoenix app using the [Phauxth authentication library](https://github.com/riverrun/phauxth).

This example was generated by running the following commands:

```elixir
mix phx.new forks_the_egg_sample # or any other suitable app name
cd forks_the_egg_sample
mix phauxth.new --confirm
```

and then making these changes:

* adding `{:phauxth, "~> 1.1"}` and `{:argon2_elixir, "~> 1.2"}` to the
mix.exs file
* replacing Bcrypt with Argon2 in the lib/forks_the_egg_sample/accounts/user.ex file
* adding `crypto: Comeonin.Argon2` to the login function in the
lib/forks_the_egg_sample_web/controllers/session_controller.ex file

At the moment, there is no email module. That is coming soon.

## Running the Phoenix app

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check the Phoenix deployment guides](http://www.phoenixframework.org/docs/deployment).

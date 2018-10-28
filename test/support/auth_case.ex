defmodule ForksTheEggSampleWeb.AuthCase do
  use Phoenix.ConnTest

  import Ecto.Changeset
  alias ForksTheEggSample.{Accounts, Repo, Sessions}
  alias ForksTheEggSampleWeb.Auth.Token

  def add_user(email) do
    user = %{email: email, password: "reallyHard2gue$$"}
    {:ok, user} = Accounts.create_user(user)
    user
  end

  def add_user_confirmed(email) do
    add_user(email)
    |> change(%{confirmed_at: DateTime.utc_now()})
    |> Repo.update!()
  end

  def add_reset_user(email) do
    add_user(email)
    |> change(%{confirmed_at: DateTime.utc_now()})
    |> change(%{reset_sent_at: DateTime.utc_now()})
    |> Repo.update!()
  end

  def add_phauxth_session(conn, user) do
    {:ok, %{id: session_id}} = Sessions.create_session(%{user_id: user.id})
    Phauxth.Authenticate.add_session(conn, session_id)
  end

  def gen_key(email), do: Token.sign(%{"email" => email})
end

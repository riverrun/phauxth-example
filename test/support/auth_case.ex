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
    |> change(%{confirmed_at: now()})
    |> Repo.update!()
  end

  def add_reset_user(email) do
    add_user(email)
    |> change(%{confirmed_at: now()})
    |> change(%{reset_sent_at: now()})
    |> Repo.update!()
  end

  def add_session(conn, user) do
    {:ok, %{id: session_id}} = Sessions.create_session(%{user_id: user.id})

    conn
    |> put_session(:phauxth_session_id, session_id)
    |> configure_session(renew: true)
  end

  def gen_key(email), do: Token.sign(%{"email" => email})

  defp now do
    DateTime.utc_now() |> DateTime.truncate(:second)
  end
end

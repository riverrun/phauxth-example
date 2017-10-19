defmodule ForksTheEggSampleWeb.SessionController do
  use ForksTheEggSampleWeb, :controller

  import ForksTheEggSampleWeb.Authorize
  alias ForksTheEggSample.Accounts
  alias Phauxth.Confirm.Login

  def new(conn, _) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => params}) do
    case Login.verify(params, Accounts, crypto: Comeonin.Argon2) do
      {:ok, user} ->
        session_id = Login.gen_session_id("F")
        Accounts.add_session(user, session_id, System.system_time(:second))
        Login.add_session(conn, session_id, user.id)
        |> add_remember_me(user.id, params)
        |> configure_session(renew: true)
        |> success("You have been logged in", user_path(conn, :index))
      {:error, message} ->
        error(conn, message, session_path(conn, :new))
    end
  end

  def delete(conn, _) do
    #Accounts.delete_session
    delete_session(conn, :phauxth_session_id)
    |> Phauxth.Remember.delete_rem_cookie
    |> success("You have been logged out", page_path(conn, :index))
  end

  # This function adds a remember_me cookie to the conn.
  # See the documentation for Phauxth.Remember for more details.
  # If you do not want this, remove this function, the
  # `|> add_remember_me(user.id, params)` line in the create function,
  # the `|> Phauxth.Remember.delete_rem_cookie` line in the delete
  # function, the `plug Phauxth.Remember` in the router.ex file
  # and edit the session/new.html.eex file.
  defp add_remember_me(conn, user_id, %{"remember_me" => "true"}) do
    Phauxth.Remember.add_rem_cookie(conn, user_id)
  end
  defp add_remember_me(conn, _, _), do: conn
end

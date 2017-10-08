defmodule ForksTheEggSampleWeb.SessionController do
  use ForksTheEggSampleWeb, :controller

  import ForksTheEggSampleWeb.Authorize
  alias Phauxth.Confirm.Login

  def new(conn, _) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => params}) do
    case Login.verify(params, ForksTheEggSample.Accounts, crypto: Comeonin.Argon2) do
      {:ok, user} ->
        put_session(conn, :user_id, user.id)
        |> configure_session(renew: true)
        |> success("You have been logged in", user_path(conn, :index))
      {:error, message} ->
        error(conn, message, session_path(conn, :new))
    end
  end

  def delete(conn, _) do
    delete_session(conn, :user_id)
    |> success("You have been logged out", page_path(conn, :index))
  end
end

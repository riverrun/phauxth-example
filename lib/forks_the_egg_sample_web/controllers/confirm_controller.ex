defmodule ForksTheEggSampleWeb.ConfirmController do
  use ForksTheEggSampleWeb, :controller

  alias Phauxth.Confirm
  alias ForksTheEggSample.Accounts
  alias ForksTheEggSampleWeb.Email

  def index(conn, params) do
    case Confirm.verify(params) do
      {:ok, user} ->
        Accounts.confirm_user(user)
        Email.confirm_success(user.email)

        conn
        |> put_flash(:info, "Your account has been confirmed")
        |> redirect(to: Routes.session_path(conn, :new))

      {:error, message} ->
        conn
        |> put_flash(:error, message)
        |> redirect(to: Routes.session_path(conn, :new))
    end
  end
end

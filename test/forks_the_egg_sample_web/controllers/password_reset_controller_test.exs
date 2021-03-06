defmodule ForksTheEggSampleWeb.PasswordResetControllerTest do
  use ForksTheEggSampleWeb.ConnCase

  import ForksTheEggSampleWeb.AuthTestHelpers

  setup %{conn: conn} do
    conn = conn |> bypass_through(ForksTheEggSampleWeb.Router, :browser) |> get("/")
    user = add_reset_user("gladys@example.com")
    {:ok, %{conn: conn, user: user}}
  end

  describe "create password reset" do
    test "user can create a password reset request", %{conn: conn} do
      valid_attrs = %{email: "gladys@example.com"}
      conn = post(conn, Routes.password_reset_path(conn, :create), password_reset: valid_attrs)
      assert get_flash(conn, :info) =~ "your inbox for instructions"
      assert redirected_to(conn) == Routes.page_path(conn, :index)
    end

    test "create function fails for no user", %{conn: conn} do
      invalid_attrs = %{email: "prettylady@example.com"}
      conn = post(conn, Routes.password_reset_path(conn, :create), password_reset: invalid_attrs)
      assert get_flash(conn, :info) =~ "your inbox for instructions"
      assert redirected_to(conn) == Routes.page_path(conn, :index)
    end
  end

  describe "update password reset" do
    test "reset password succeeds for correct key", %{conn: conn} do
      valid_attrs = %{key: gen_key("gladys@example.com"), password: "^hEsdg*F899"}

      reset_conn =
        put(conn, Routes.password_reset_path(conn, :update), password_reset: valid_attrs)

      assert get_flash(reset_conn, :info) =~ "password has been reset"
      assert redirected_to(reset_conn) == Routes.session_path(conn, :new)

      conn =
        post(conn, Routes.session_path(conn, :create),
          session: %{email: "gladys@example.com", password: "^hEsdg*F899"}
        )

      assert redirected_to(conn) == Routes.user_path(conn, :index)
    end

    test "reset password fails for incorrect key", %{conn: conn} do
      invalid_attrs = %{password: "^hEsdg*F899", key: "garbage"}
      conn = put(conn, Routes.password_reset_path(conn, :update), password_reset: invalid_attrs)
      assert get_flash(conn, :error) =~ "Invalid credentials"
    end

    test "sessions are deleted when user updates password", %{conn: conn, user: user} do
      add_session(conn, user)
      valid_attrs = %{key: gen_key("gladys@example.com"), password: "^hEsdg*F899"}

      reset_conn =
        put(conn, Routes.password_reset_path(conn, :update), password_reset: valid_attrs)

      refute get_session(reset_conn, :phauxth_session_id)
    end
  end
end

defmodule ForksTheEggSampleWeb.SessionControllerTest do
  use ForksTheEggSampleWeb.ConnCase

  import ForksTheEggSampleWeb.AuthCase

  @create_attrs %{email: "robin@example.com", password: "reallyHard2gue$$"}
  @invalid_attrs %{email: "robin@example.com", password: "cannotGue$$it"}
  @unconfirmed_attrs %{email: "lancelot@example.com", password: "reallyHard2gue$$"}
  @rem_attrs %{email: "robin@example.com", password: "reallyHard2gue$$", remember_me: "true"}
  @no_rem_attrs Map.merge(@rem_attrs, %{remember_me: "false"})

  setup %{conn: conn} do
    conn = conn |> bypass_through(ForksTheEggSampleWeb.Router, [:browser]) |> get("/")
    add_user("lancelot@example.com")
    user = add_user_confirmed("robin@example.com")
    {:ok, %{conn: conn, user: user}}
  end

  test "login succeeds", %{conn: conn} do
    conn = post conn, session_path(conn, :create), session: @create_attrs
    assert redirected_to(conn) == user_path(conn, :index)
  end

  test "login fails for user that is not yet confirmed", %{conn: conn} do
    conn = post conn, session_path(conn, :create), session: @unconfirmed_attrs
    assert redirected_to(conn) == session_path(conn, :new)
  end

  test "login fails for invalid password", %{conn: conn} do
    conn = post conn, session_path(conn, :create), session: @invalid_attrs
    assert redirected_to(conn) == session_path(conn, :new)
  end

  test "logout succeeds", %{conn: conn, user: user} do
    conn = conn |> put_session(:user_id, user.id) |> send_resp(:ok, "/")
    conn = delete conn, session_path(conn, :delete, user)
    assert redirected_to(conn) == page_path(conn, :index)
    conn = get conn, user_path(conn, :index)
    assert redirected_to(conn) == session_path(conn, :new)
  end

  test "remember me cookie is added / not added", %{conn: conn} do
    rem_conn = post conn, session_path(conn, :create), session: @rem_attrs
    assert rem_conn.resp_cookies["remember_me"]
    no_rem_conn = post conn, session_path(conn, :create), session: @no_rem_attrs
    refute no_rem_conn.resp_cookies["remember_me"]
  end
end

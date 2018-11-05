defmodule ForksTheEggSampleWeb.PageControllerTest do
  use ForksTheEggSampleWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to Phauxth!"
  end
end

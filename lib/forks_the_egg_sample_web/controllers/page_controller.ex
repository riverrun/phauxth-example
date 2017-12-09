defmodule ForksTheEggSampleWeb.PageController do
  use ForksTheEggSampleWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end

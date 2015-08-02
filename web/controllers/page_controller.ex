defmodule DemoPhoenixOauth.PageController do
  use DemoPhoenixOauth.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end

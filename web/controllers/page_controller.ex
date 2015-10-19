defmodule Vault.PageController do
  use Vault.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end

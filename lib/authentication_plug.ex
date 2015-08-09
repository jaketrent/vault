defmodule AuthenticationPlug do
  @moduledoc """
  Authenticated plug can be used to filter actions for users that are
  authenticated.
  """
  import Plug.Conn

  def init(options) do
    options
  end

  @doc """
  Call represents the use of the plug itself.

  When called, it will assign `current_user` to `conn`, so it is
  possible to always retrieve the user via `conn.assigns.current_user`.
  """
  def call(conn, _) do
    conn = fetch_session(conn)

    if is_logged_in?(get_session(conn, :current_user)) do
      assign(conn, :current_user, get_session(conn, :current_user))
    else
      conn |> Phoenix.Controller.json(fmt_not_auth_error) |> halt
    end
  end

  def is_logged_in?(user_session) do
    case user_session do
      nil -> false
      _   -> true
    end
  end

  defp fmt_not_auth_error do
    %{ errors: [%{
      detail: "User not authenticated",
      status: 401
    }]}
  end
end
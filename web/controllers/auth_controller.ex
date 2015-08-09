defmodule DemoPhoenixOauth.AuthController do
  use DemoPhoenixOauth.Web, :controller

  # plug :action

  def login(conn, _params) do
    IO.puts ("-------here!")
    redirect conn, external: GitHubAuth.authorize_url!
  end

  def current(conn, _params) do
    current_user = fetch_session(conn)
    |> get_session(:current_user)
    json(conn, %{ data: current_user })
  end

  def logout(conn, _params) do
    IO.puts("-----out")
    fetch_session(conn)
    |> delete_session(:current_user)
    |> delete_session(:access_token)
    |> redirect(to: "/")
  end


  @doc """
  This action is reached via `/auth/callback` is the the callback URL that
  the OAuth2 provider will redirect the user back to with a `code` that will
  be used to request an access token. The access token will then be used to
  access protected resources on behalf of the user.
  """
  def callback(conn, %{"code" => code}) do
    token = GitHubAuth.get_token!(code: code)

    user = OAuth2.AccessToken.get!(token, "/user")

    IO.inspect(user)

    if (is_authz?(user)) do
      conn
      |> put_session(:current_user, user)
      |> put_session(:access_token, token.access_token)
      |> html("<html><body><script>window.close()</script></body></html>")
    else
      conn
      |> put_status(:unauthorized)
      |> redirect(to: "/")
    end
  end

  defp is_authz?(user) do
    Map.get(user, "login") == "jaketrent"
  end

end

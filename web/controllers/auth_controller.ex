defmodule DemoPhoenixOauth.AuthController do
  use DemoPhoenixOauth.Web, :controller

  # plug :action

  def login(conn, _params) do
    IO.puts ("-------here!")
    redirect conn, external: GitHubAuth.authorize_url!
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
    # Exchange an auth code for an access token
    token = GitHubAuth.get_token!(code: code)

    # Request the user's data with the access token
    user = OAuth2.AccessToken.get!(token, "/user")

    IO.inspect(user)

    if (is_authz?(user)) do

      # Store the user in the session under `:current_user` and redirect to /.
      # In most cases, we'd probably just store the user's ID that can be used
      # to fetch from the database. In this case, since this example app has no
      # database, I'm just storing the user map.
      #
      # If you need to make additional resource requests, you may want to store
      # the access token as well.
      conn
      |> put_session(:current_user, user)
      |> put_session(:access_token, token.access_token)
      |> redirect(to: "/")
      # TODO: render html with js close (see jaketrent-books)
    else
      redirect(conn, to: "/?auth=false")
      # TODO: put status for error
    end
  end

  defp is_authz?(user) do
    Map.get(user, "login") == "jaketrent"
  end

end

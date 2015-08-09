defmodule DemoPhoenixOauth.Router do
  use DemoPhoenixOauth.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :assign_current_user
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug AuthenticationPlug
  end

  scope "/", DemoPhoenixOauth do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/api", DemoPhoenixOauth do
    pipe_through :api

    scope "/v1", V1, as: :v1 do
      resources "/books", BookController
      resources "/quotes", QuoteController
    end
  end

  scope "/auth", alias: DemoPhoenixOauth do
    pipe_through :browser

    get "/login", AuthController, :login
    get "/logout", AuthController, :logout
    get "/current", AuthController, :current
    get "/callback", AuthController, :callback
  end

  # Fetch the current user from the session and add it to `conn.assigns`. This
  # will allow you to have access to the current user in your views with
  # `@current_user`.
  defp assign_current_user(conn, _) do
    assign(conn, :current_user, get_session(conn, :current_user))
  end
end

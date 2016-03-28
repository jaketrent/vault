defmodule Vault.Endpoint do
  use Phoenix.Endpoint, otp_app: :vault

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phoenix.digest
  # when deploying your static files in production.
  plug Plug.Static,
    at: "/", from: :vault, gzip: false,
    only: ~w(css images js favicon.ico robots.txt)

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId
  plug Plug.Logger
  plug Corsica,
    origins: (if (System.get_env("ALLOWED_ORIGINS")), do: String.split(System.get_env("ALLOWED_ORIGINS"), ",", trim: true), else: "*"),
    allow_headers: ~w(access),
    expose_headers: ~w(Link),
    allow_credentials: true

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session,
    store: :cookie,
    key: "_vault_key",
    signing_salt: "7WTy/lJ/"

  plug Vault.Router
end

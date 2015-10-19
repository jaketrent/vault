defmodule Vault.Repo do
  use Ecto.Repo, otp_app: :vault
  use Scrivener, page_size: 30
end

defmodule Vault.Repo.Migrations.CreateQuote do
  use Ecto.Migration

  def change do
    create table(:quotes) do
      add :title, :string
      add :body, :string
      add :author, :string

      timestamps
    end

  end
end

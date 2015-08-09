defmodule DemoPhoenixOauth.Repo.Migrations.CreateBook do
  use Ecto.Migration

  def change do
    create table(:books) do
      add :title, :string
      add :author, :string
      add :description, :string
      add :cover_url, :string
      add :complete_date, :date
      add :review_url, :string
      add :affiliate_url, :string

      timestamps
    end

  end
end

defmodule DemoPhoenixOauth.Book do
  use DemoPhoenixOauth.Web, :model

  schema "books" do
    field :title, :string
    field :author, :string
    field :description, :string
    field :cover_url, :string
    field :complete_date, Ecto.Date
    field :review_url, :string
    field :affiliate_url, :string

    timestamps
  end

  @required_fields ~w(title author description cover_url complete_date)
  @optional_fields ~w(review_url affiliate_url)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end

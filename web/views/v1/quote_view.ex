defmodule Vault.V1.QuoteView do
  use Vault.Web, :view

  def render("index.json", %{quotes: quotes}) do
    %{data: render_many(quotes, Vault.V1.QuoteView, "quote.json")}
  end

  def render("show.json", %{quote: quote}) do
    %{data: render_one(quote, Vault.V1.QuoteView, "quote.json")}
  end

  def render("quote.json", %{quote: quote}) do
    quote
  end
end

defimpl Poison.Encoder, for: Vault.Quote do
  def encode(quote, _options) do
    %{
      title: quote.title,
      body: quote.body,
      author: quote.author,
      createdAt: quote.inserted_at
    } |> Poison.Encoder.encode([])
  end
end

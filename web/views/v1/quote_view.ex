defmodule DemoPhoenixOauth.V1.QuoteView do
  use DemoPhoenixOauth.Web, :view

  def render("index.json", %{quotes: quotes}) do
    %{data: render_many(quotes, DemoPhoenixOauth.V1.QuoteView, "quote.json")}
  end

  def render("show.json", %{quote: quote}) do
    %{data: render_one(quote, DemoPhoenixOauth.V1.QuoteView, "quote.json")}
  end

  def render("quote.json", %{quote: quote}) do
    quote
  end
end

defimpl Poison.Encoder, for: DemoPhoenixOauth.Quote do
  def encode(quote, _options) do
    %{
      title: quote.title,
      body: quote.body,
      author: quote.author,
      createdAt: quote.inserted_at
    } |> Poison.Encoder.encode([])
  end
end

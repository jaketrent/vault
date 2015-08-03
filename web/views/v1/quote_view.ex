defmodule DemoPhoenixOauth.V1.QuoteView do
  use DemoPhoenixOauth.Web, :view

  def render("index.json", %{quotes: quotes}) do
    %{data: render_many(quotes, DemoPhoenixOauth.V1.QuoteView, "quote.json")}
  end

  def render("show.json", %{quote: quote}) do
    %{data: render_one(quote, DemoPhoenixOauth.V1.QuoteView, "quote.json")}
  end

  def render("quote.json", %{quote: quote}) do
    %{id: quote.id}
  end
end

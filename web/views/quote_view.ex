defmodule DemoPhoenixOauth.QuoteView do
  use DemoPhoenixOauth.Web, :view

  def render("index.json", %{quotes: quotes}) do
    %{data: render_many(quotes, "quote.json")}
  end

  def render("show.json", %{quote: quote}) do
    %{data: render_one(quote, "quote.json")}
  end

  def render("quote.json", %{quote: quote}) do
    %{id: quote.id}
  end
end

defmodule DemoPhoenixOauth.BookView do
  use DemoPhoenixOauth.Web, :view

  def render("index.json", %{books: books}) do
    %{data: render_many(books, "book.json")}
  end

  def render("show.json", %{book: book}) do
    %{data: render_one(book, "book.json")}
  end

  def render("book.json", %{book: book}) do
    %{id: book.id}
  end
end

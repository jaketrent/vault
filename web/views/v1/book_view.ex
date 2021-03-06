defmodule Vault.V1.BookView do
  use Vault.Web, :view

  def render("index.json", %{books: books}) do
    %{data: render_many(books, Vault.V1.BookView, "book.json")}
  end

  def render("show.json", %{book: book}) do
    %{data: render_many([book], Vault.V1.BookView, "book.json")}
  end

  def render("book.json", %{book: book}) do
    %{
      id: book.id,
      title: book.title,
      author: book.author,
      description: book.description,
      completeDate: book.complete_date,
      coverUrl: book.cover_url,
      reviewUrl: book.review_url,
      affiliateUrl: book.affiliate_url,
      createdAt: book.inserted_at
    }
  end
end

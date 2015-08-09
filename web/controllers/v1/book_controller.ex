defmodule DemoPhoenixOauth.V1.BookController do
  use DemoPhoenixOauth.Web, :controller

  alias DemoPhoenixOauth.Book

  plug :scrub_params, "book" when action in [:create, :update]

  def index(conn, _params) do
    books = Repo.all(Book)
    render(conn, "index.json", books: books)
  end

  def create(conn, %{"book" => book_params}) do
    changeset = Book.changeset(%Book{}, book_params)

    case Repo.insert(changeset) do
      {:ok, book} ->
        render(conn, "show.json", book: book)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(DemoPhoenixOauth.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    book = Repo.get!(Book, id)
    render conn, "show.json", book: book
  end

  def update(conn, %{"id" => id, "book" => book_params}) do
    book = Repo.get!(Book, id)
    changeset = Book.changeset(book, book_params)

    case Repo.update(changeset) do
      {:ok, book} ->
        render(conn, "show.json", book: book)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(DemoPhoenixOauth.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    book = Repo.get!(Book, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    book = Repo.delete!(book)

    send_resp(conn, :no_content, "")
  end
end

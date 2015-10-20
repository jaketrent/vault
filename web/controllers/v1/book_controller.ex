defmodule Vault.V1.BookController do
  use Vault.Web, :controller

  alias Vault.Book
  alias Vault.Router.Helpers, as: RouterHelpers

  plug :scrub_params, "data" when action in [:create, :update]

  def index(conn, _params) do
    page = Book
    |> Book.by_completion
    |> Vault.Repo.paginate(_params)

    conn
    |> merge_resp_headers([
      { "Link", LinkFormatter.format(RouterHelpers.v1_book_url(conn, :index), page) }
    ])
    |> render("index.json", books: page.entries)
  end

  def create(conn, %{"data" => book_params}) do
    changeset = Book.changeset(%Book{}, underscorize(book_params))

    case Repo.insert(changeset) do
      {:ok, book} ->
        conn
        |> put_status(:created)
        |> render("show.json", book: book)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Vault.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    book = Repo.get!(Book, id)
    render conn, "show.json", book: book
  end

  def update(conn, %{"id" => id, "data" => book_params}) do
    book = Repo.get!(Book, id)
    changeset = Book.changeset(book, book_params)

    case Repo.update(changeset) do
      {:ok, book} ->
        render(conn, "show.json", book: book)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Vault.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    book = Repo.get!(Book, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    book = Repo.delete!(book)

    send_resp(conn, :no_content, "")
  end

  defp convert_string_to_atom_keys(map) do
    for {key, val} <- map, into: %{}, do: {String.to_atom(key), val}
  end

  defp underscorize(map) do
    for {key, val} <- map, into: %{}, do: {Mix.Utils.underscore(key), val}
  end
end

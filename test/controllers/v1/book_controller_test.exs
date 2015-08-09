defmodule DemoPhoenixOauth.V1.BookControllerTest do
  use DemoPhoenixOauth.ConnCase

  alias DemoPhoenixOauth.Book
  @valid_attrs %{affiliate_url: "some content", author: "some content", complete_date: %{day: 17, month: 4, year: 2010}, cover_url: "some content", description: "some content", review_url: "some content", title: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, v1_book_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    book = Repo.insert! %Book{}
    conn = get conn, v1_book_path(conn, :show, book)
    assert json_response(conn, 200)["data"] == %{
      "id" => book.id
    }
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, v1_book_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, v1_book_path(conn, :create), book: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Book, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, v1_book_path(conn, :create), book: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    book = Repo.insert! %Book{}
    conn = put conn, v1_book_path(conn, :update, book), book: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Book, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    book = Repo.insert! %Book{}
    conn = put conn, v1_book_path(conn, :update, book), book: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    book = Repo.insert! %Book{}
    conn = delete conn, v1_book_path(conn, :delete, book)
    assert response(conn, 204)
    refute Repo.get(Book, book.id)
  end
end

defmodule DemoPhoenixOauth.BookTest do
  use DemoPhoenixOauth.ModelCase

  alias DemoPhoenixOauth.Book

  @valid_attrs %{affiliate_url: "some content", author: "some content", complete_date: %{day: 17, month: 4, year: 2010}, cover_url: "some content", description: "some content", review_url: "some content", title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Book.changeset(%Book{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Book.changeset(%Book{}, @invalid_attrs)
    refute changeset.valid?
  end
end

defmodule LinkFormatter do
  def format(url, page) do
    link = ""

    has_next = page.page_number < page.total_pages
    has_prev = page.page_number > 1

    if (has_next) do
      link = link <> "<" <> url <> "?page=" <> Integer.to_string(page.page_number + 1) <> ">; rel=\"next\""
    end

    if (has_next && has_prev) do
      link = link <> ","
    end

    if (has_prev) do
      link = link <> "<" <> url <> "?page=" <> Integer.to_string(page.page_number - 1) <> ">; rel=\"prev\""
    end

    link
  end
end

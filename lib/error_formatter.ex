defmodule ErrorFormatter do
  def get_msg(error) do
    case Map.fetch(error, :message) do
      {:ok, msg} ->
        msg
      _ ->
        "Not found -- generically"
    end
  end

  def fmt_detail(msg) do
    String.replace(msg, "\n", " ")
    |> String.capitalize
  end

  def fmt_detail(key, msg) do
    (Atom.to_string(key) <> " " <> msg)
    |> fmt_detail
  end

  def fmt_pointer() do
    %{ pointer: "/data" }
  end

  def fmt_pointer(key) do
    %{ pointer: "/data" <> "/" <> Atom.to_string(key) }
  end
end

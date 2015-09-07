import Phoenix.Naming, only: [camelize: 1, humanize: 1]

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
    (humanize(Atom.to_string(key)) <> " " <> msg)
    |> fmt_detail
  end

  def fmt_pointer() do
    %{ pointer: "/data" }
  end

  def fmt_pointer(key) do
    %{ pointer: "/data" <> "/" <> fmt_key(key) }
  end

  defp fmt_key(key) do
    camel = camelize(Atom.to_string(key))
    String.downcase(String.slice(camel, 0, 1)) <> String.slice(camel, 1..-1)
  end
end

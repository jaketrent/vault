defmodule DemoPhoenixOauth.ChangesetView do
  use DemoPhoenixOauth.Web, :view

  def render("error.json", %{changeset: changeset}) do
    %{errors: Enum.map(changeset.errors, &fmt_validation_error/1)}
  end

  defp fmt_validation_error({ key, err }) do
    %{ detail: fmt_detail(key, err),
       source: fmt_pointer(key),
       status: 422 }
  end

  defp fmt_detail(key, err) do
   String.capitalize(Atom.to_string(key)) <> " " <> err
  end

  defp fmt_pointer(key) do
    %{ pointer: "/data" <> "/" <> Atom.to_string(key) }
  end
end


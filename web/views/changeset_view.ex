defmodule DemoPhoenixOauth.ChangesetView do
  use DemoPhoenixOauth.Web, :view

  def render("error.json", %{changeset: changeset}) do
    %{errors: Enum.map(changeset.errors, &fmt_validation_error/1)}
  end

  defp fmt_validation_error({ key, err }) do
    %{ detail: ErrorFormatter.fmt_detail(key, err),
       source: ErrorFormatter.fmt_pointer(key),
       status: 422 }
  end
end


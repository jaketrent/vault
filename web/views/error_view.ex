defmodule Vault.ErrorView do
  use Vault.Web, :view

  def render("400.json", assigns) do
    %{errors: [render_one(assigns.reason, Vault.ErrorView, "error.json") ]}
  end

  def render("404.json", assigns) do
    %{errors: [render_one(assigns.reason, Vault.ErrorView, "error.json") ]}
  end

  def render("500.json", assigns) do
    %{errors: [render_one(assigns.reason, Vault.ErrorView, "error.json") ]}
  end

  def render("error.json", reason) do
    reason.error
  end

  # In case no render clause matches or no
  # template is found, let's render it as 500
  def template_not_found(_template, assigns) do
    render "500.json", assigns
  end
end

defimpl Poison.Encoder, for: Phoenix.MissingParamError do
  def encode(error, _options) do
    %{
      detail: ErrorFormatter.get_msg(error)
              |> ErrorFormatter.fmt_detail,
      status: 422,
      source: ErrorFormatter.fmt_pointer()
    } |> Poison.Encoder.encode([])
  end
end

defimpl Poison.Encoder, for: Ecto.NoResultsError do
  def encode(error, _options) do
    %{
      detail: ErrorFormatter.get_msg(error)
              |> ErrorFormatter.fmt_detail,
      status: 404
    } |> Poison.Encoder.encode([])
  end
end

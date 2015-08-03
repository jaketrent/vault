defmodule DemoPhoenixOauth.ErrorView do
  use DemoPhoenixOauth.Web, :view

  def render("404.json", assigns) do
    %{errors: [render_one(assigns.reason, QuotesApi.ErrorView, "error.json") ]}
  end

  def render("500.json", assigns) do
    %{errors: [render_one(assigns.reason, QuotesApi.ErrorView, "error.json") ]}
  end

  def render("error.json", reason) do
    status = Map.fetch(reason.error, :plug_status)
    %{ code: get_code(status),
       detail: (if Map.has_key?(reason.error, :message), do: String.capitalize(reason.error.message), else: "Generic Error"),
       status: status }
  end

  # In case no render clause matches or no
  # template is found, let's render it as 500
  def template_not_found(_template, assigns) do
    render "500.json", assigns
  end

  defp get_code(plug_status) do
    case plug_status do
      400 -> "bad-request"
      404 -> "not-found"
      422 -> "validation"
      _ -> "internal-server"
    end
  end
end

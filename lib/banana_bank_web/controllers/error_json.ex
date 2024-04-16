defmodule BananaBankWeb.ErrorJSON do
  alias Ecto.Changeset

  def error(%{status: :not_found}) do
    %{errors: %{detail: "Resource Not Found"}}
  end

  def error(%{status: :bad_request}) do
    %{errors: %{detail: "Bad Request"}}
  end

  def error(%{status: :internal_server_error}) do
    %{errors: %{detail: "Internal Server Error"}}
  end

  def error(%{changeset: changeset}) do
    %{errors: Changeset.traverse_errors(changeset, &format_error/1)}
  end

  def error(%{status: 401}) do
    %{errors: %{detail: "Unauthorized"}}
  end

  defp format_error({msg, opts}) do
    Regex.replace(~r"%{(\w+)}", msg, fn _, key ->
      opts |> Keyword.get(String.to_existing_atom(key), key) |> to_string()
    end)
  end
end

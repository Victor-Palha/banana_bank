defmodule BananaBank.ViaCep.Client do
  use Tesla

  @behaviour BananaBank.ViaCep.ClientBehaviour

  plug Tesla.Middleware.BaseUrl, "https://viacep.com.br/ws/"
  plug Tesla.Middleware.Headers, [{"authorization", "token xyz"}]
  plug Tesla.Middleware.JSON

  @impl BananaBank.ViaCep.ClientBehaviour
  def get_cep(cep) do
    case get(cep <> "/json") do
      {:ok, %Tesla.Env{status: 200, body: %{"erro" => true}}} -> {:error, :not_found}
      {:ok, %Tesla.Env{status: 200, body: body}} -> {:ok, body}
      {:ok, %Tesla.Env{status: 400}} -> {:error, :bad_request}
      {:ok, %Tesla.Env{status: 404}} -> {:error, :not_found}
      {:ok, %Tesla.Env{status: 403}} -> {:error, :forbidden}
      {:error, _} -> {:error, :internal_server_error}
    end
  end
end

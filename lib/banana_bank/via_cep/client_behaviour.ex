defmodule BananaBank.ViaCep.ClientBehaviour do
  @callback get_cep(String.t()) :: {:ok, map()} | {:error, atom()}
end

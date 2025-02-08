defmodule BananaBank.Accounts.Create do
  alias BananaBank.Accounts.Account
  alias BananaBank.Repo

  def call(params) do
    params
    |> Account.changeset()
    |> Repo.insert()
  end

  defp client() do
    Application.get_env(:banana_bank, :via_cep_client, ViaCepClient)
  end
end

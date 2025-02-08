defmodule BananaBank.Accounts do
  alias BananaBank.Accounts.Account
  defdelegate create(params), to: Create, as: :call
end

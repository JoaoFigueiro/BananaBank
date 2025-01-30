defmodule BananaBank.Users do
  alias BananaBank.Users.Create
  defdelegate create(params), Create, as: :call
end
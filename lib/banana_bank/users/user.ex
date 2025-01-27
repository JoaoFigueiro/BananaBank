defmodule BananaBank.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :name, :string
    field :password_hash, :string
    field :email, :string
    field :cep, :string

    timestamps()
  end

  def changeset(user \\ %__MODULE__{}, params) do
    attributes = [:name, :password_hash, :email, :cep]
    user
    |> cast(params, attributes)
    |> validate_required(attributes)
  end
end
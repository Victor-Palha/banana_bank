defmodule BananaBank.Accounts.Account do
  use Ecto.Schema
  import Ecto.Changeset
  alias BananaBank.Users.User

  @required_fields_create [:balance, :user_id]

  schema "accounts" do
    field :balance, :decimal, default: 0
    belongs_to :user, User

    timestamps()
  end

  def changeset(account \\ %__MODULE__{}, params) do
    account
    |> cast(params, @required_fields_create)
    |> validate_required(@required_fields_create)
    |> check_constraint(:balance, name: :balance_must_be_positive)
    |> unique_constraint(:user_id, name: :unique_user_relation)
  end
end

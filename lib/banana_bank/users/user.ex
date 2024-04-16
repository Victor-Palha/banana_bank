defmodule BananaBank.Users.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias BananaBank.Accounts.Account

  @required_fields_create [:name, :email, :password, :cep]
  @required_fields_update [:name, :email, :cep]

  schema "users" do
    field :name, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :cep, :string
    has_one :accounts, Account

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_fields_create)
    |> do_validations(@required_fields_create)
    |> validate_password()
  end

  def changeset(user, params) do
    user
    |> cast(params, @required_fields_update)
    |> do_validations(@required_fields_update)
    |> validate_password()
  end


  def do_validations(changeset, field_validations) do
    changeset
    |> validate_required(field_validations)
    |> unique_constraint(:email, name: :unique_email)
    |> validate_length(:cep, is: 8)
    |> validate_format(:email, ~r/@/)
  end

  def validate_password(
        %Ecto.Changeset{
          valid?: true,
          changes: %{password: password}
        } = changeset
      ),
      do: change(changeset, %{password_hash: Argon2.hash_pwd_salt(password)})

  def validate_password(changeset), do: changeset
end

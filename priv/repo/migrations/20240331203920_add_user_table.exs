defmodule BananaBank.Repo.Migrations.AddUserTable do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string, null: false
      add :email, :string, null: false, unique: true
      add :password_hash, :string, null: false
      add :cep, :string, null: false

      timestamps()
    end
  end
end

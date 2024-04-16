defmodule BananaBank.Repo.Migrations.AddNewConstraint do
  use Ecto.Migration

  def change do
    create unique_index(:accounts, [:user_id], name: :unique_user_relation)
  end
end

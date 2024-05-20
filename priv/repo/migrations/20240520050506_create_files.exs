defmodule FileShare.Repo.Migrations.CreateFiles do
  use Ecto.Migration

  def change do
    create table(:files) do
      add :name, :string
      add :path, :string
      add :password, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:files, [:user_id])
  end
end

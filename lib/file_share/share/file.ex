defmodule FileShare.Share.File do
  alias FileShare.Accounts.User
  use Ecto.Schema
  import Ecto.Changeset

  schema "files" do
    field :name, :string
    field :path, :string
    field :password, :string
    belongs_to :user, User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(file, attrs) do
    file
    |> cast(attrs, [:name, :path, :password, :user_id])
    |> validate_required([:name, :path, :user_id])
  end
end

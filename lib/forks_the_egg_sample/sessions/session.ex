defmodule ForksTheEggSample.Sessions.Session do
  use Ecto.Schema

  import Ecto.Changeset

  alias ForksTheEggSample.Accounts.User

  schema "sessions" do
    belongs_to(:user, User)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:user_id])
    |> validate_required([:user_id])
  end
end

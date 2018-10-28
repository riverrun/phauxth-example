defmodule ForksTheEggSample.Sessions do
  @moduledoc """
  The Sessions context.
  """

  import Ecto.Query, warn: false

  alias ForksTheEggSample.Repo
  alias ForksTheEggSample.Accounts.User
  alias ForksTheEggSample.Sessions.Session

  @doc """
  Returns a list of sessions for the user.
  """
  def list_sessions(%User{} = user) do
    Repo.all(from(s in Session, where: s.user_id == ^user.id))
  end

  @doc """
  Gets a single user.
  """
  def get_session(id), do: Repo.get(Session, id)

  @doc """
  Creates a session.
  """
  def create_session(attrs \\ %{}) do
    %Session{}
    |> Session.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Deletes a session.
  """
  def delete_session(%Session{} = session) do
    Repo.delete(session)
  end

  @doc """
  Deletes a session.
  """
  def delete_user_sessions(%User{} = user) do
    Repo.delete_all(from(s in Session, where: s.user_id == ^user.id))
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.
  """
  def change_session(%Session{} = session) do
    Session.changeset(session, %{})
  end
end

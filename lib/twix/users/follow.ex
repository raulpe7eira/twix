defmodule Twix.Users.Follow do
  alias Twix.Repo
  alias Twix.Users.Follower
  alias Twix.Users.User

  def call(%{user_id: user_id, follower_id: follower_id}) do
    with :ok <- check_user(user_id),
         :ok <- check_user(follower_id) do
      create_follower(user_id, follower_id)
    end
  end

  defp check_user(id) do
    case Repo.get(User, id) do
      nil -> {:error, :not_found}
      _ -> :ok
    end
  end

  defp create_follower(user_id, follower_id) do
    %{following_id: user_id, follower_id: follower_id}
    |> Follower.changeset()
    |> Repo.insert()
  end
end

defmodule Twix.Posts.AddLike do
  alias Twix.Repo
  alias Twix.Posts.Post

  def call(id) do
    case Repo.get(Post, id) do
      nil -> {:error, :not_found}
      post -> add_like(post)
    end
  end

  defp add_like(post) do
    params = %{likes: post.likes + 1}

    post
    |> Post.changeset(params)
    |> Repo.update()
  end
end

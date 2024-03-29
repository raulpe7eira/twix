defmodule Twix do
  alias Twix.Posts
  alias Twix.Users

  defdelegate add_like_to_post(params), to: Posts.AddLike, as: :call
  defdelegate create_post(params), to: Posts.Create, as: :call
  defdelegate get_posts_by_user(user, params), to: Posts.Get, as: :call

  defdelegate add_follower_user(params), to: Users.AddFollower, as: :call
  defdelegate create_user(params), to: Users.Create, as: :call
  defdelegate get_user(params), to: Users.Get, as: :call
  defdelegate update_user(params), to: Users.Update, as: :call
end

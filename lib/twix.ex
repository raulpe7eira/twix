defmodule Twix do
  alias Twix.Posts
  alias Twix.Users

  defdelegate create_post(params), to: Posts.Create, as: :call
  defdelegate add_like_to_post(params), to: Posts.AddLike, as: :call

  defdelegate create_user(params), to: Users.Create, as: :call
  defdelegate get_user(params), to: Users.Get, as: :call
  defdelegate update_user(params), to: Users.Update, as: :call
end

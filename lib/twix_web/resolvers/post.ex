defmodule TwixWeb.Resolvers.Post do
  def add_like(%{id: id}, _ctx), do: Twix.add_like_to_post(id)
  def create(%{input: params}, _ctx), do: Twix.create_post(params)
end

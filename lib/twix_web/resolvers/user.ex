defmodule TwixWeb.Resolvers.User do
  def create(%{input: params}, _ctx), do: Twix.create_user(params)
  def get(%{id: id}, _ctx), do: Twix.get_user(id)
  def update(%{input: params}, _ctx), do: Twix.update_user(params)
end

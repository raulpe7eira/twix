defmodule TwixWeb.Resolvers.User do
  def add_follower(%{input: params}, _ctx) do
    # with {:ok, result} <- Twix.add_follower_user(params) do
    #   Absinthe.Subscription.publish(TwixWeb.Endpoint, result, new_follow: "new_follow_topic")
    #   {:ok, result}
    # end
    Twix.add_follower_user(params)
  end

  def create(%{input: params}, _ctx), do: Twix.create_user(params)
  def get(%{id: id}, _ctx), do: Twix.get_user(id)
  def update(%{input: params}, _ctx), do: Twix.update_user(params)
end

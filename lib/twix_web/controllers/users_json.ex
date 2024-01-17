defmodule TwixWeb.UsersJSON do
  def index(%{data: %{users: users}}) do
    %{users: for(user <- users, do: user(user))}
  end

  def user(user) do
    %{id: user.id, nickname: user.nickname, email: user.email, age: user.age}
  end
end

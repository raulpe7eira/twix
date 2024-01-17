defmodule Twix.Users.Follower do
  use Ecto.Schema

  import Ecto.Changeset

  alias Twix.Users.User

  @fields [:follower_id, :following_id]
  @required_fields @fields

  @primary_key false
  schema "followers" do
    belongs_to :follower, User
    belongs_to :following, User
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @fields)
    |> validate_required(@required_fields)
    |> unique_constraint(@required_fields)
  end
end

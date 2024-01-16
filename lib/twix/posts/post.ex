defmodule Twix.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  alias Twix.Users.User

  @fields [:text, :likes, :user_id]
  @required_fields @fields

  schema "posts" do
    field :text, :string
    field :likes, :integer, default: 0

    belongs_to :user, User

    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @fields)
    |> validate_required(@required_fields)
    |> validate_length(:text, min: 1, max: 300)
    |> foreign_key_constraint(:user_id)
    |> unique_constraint(:user_id)
  end
end

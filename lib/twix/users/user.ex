defmodule Twix.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Twix.Posts.Post

  @fields [:nickname, :email, :age]
  @required_fields @fields

  schema "users" do
    field :nickname, :string
    field :email, :string
    field :age, :integer

    has_many :posts, Post

    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @fields)
    |> validate_required(@required_fields)
    |> validate_length(:nickname, min: 1)
    |> validate_number(:age, greater_than_or_equal_to: 18)
    |> unique_constraint(:nickname)
    |> unique_constraint(:email)
  end
end

# Twix

This code corresponding to the [Crie APIs GraphQL com Elixir e Absinthe by Rafael Camarda](https://www.udemy.com/course/elixir-graphql) lab.

> The project simulates a twitter, where it's possible to register a user, add follower, send posts, and like posts.

## Compilation, tests and runs

```bash
$ cd twix
$ asdf install
$ mix compile
$ mix ecto.setup
$ mix test
$ iex -S mix phx.server
```

## How to use?

```bash
# provide resources graphql
curl -X POST 'http://localhost:4000/api/graphql'

# provide resources graphql w/ web development interface
curl -X POST 'http://localhost:4000/api/graphiql'

# retrieve all users (
#   rest endpoint consuming graphql
# )
curl -X GET 'http://localhost:4000/api/users'
```

### Resources GraphQL

```bash
# retrieve user (
#   the posts is paginated
# )
query{
  user(id: 1) {
    nickname
    email
    age
    followers{
      follower{
        nickname
      }
    }
    followings{
      following{
        nickname
      }
    }
    posts(page: 1, perPage: 1){
      id
      text
      likes
    }
  }
}

# retrieve all users
query{
  users{
    id
    nickname
    email
    age
  }
}

# create user
mutation{
  createUser(input: {nickname: "Raul", email: "raul@mail.com", age: 42}){
    id
    nickname
    email
    age
  }
}

# update user
mutation{
  updateUser(input: {id: 1, age: 43}){
    id
    nickname
    email
    age
  }
}

# add follower
mutation{
  addFollower(input: {userId: 1, followerId: 2}){
    followerId
    followingId
  }
}

# -----------------------------------------------------------------------------

# create post
mutation{
  createPost(input: {userId: 1, text: "Olá mundo"}){
    id
    text
    likes
  }
}

# like a post
mutation{
  addLikeToPost(id: 1){
    id
    text
    likes
  }
}
```

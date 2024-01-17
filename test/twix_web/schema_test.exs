defmodule TwixWeb.SchemaTest do
  use TwixWeb.ConnCase, async: true

  describe "users query" do
    test "when given a valid request, returns an user", ctx do
      user_params = %{nickname: "Raul", age: 43, email: "raul@mail.com"}

      {:ok, user} = Twix.create_user(user_params)

      query = """
      {
        user(id: #{user.id}){
          nickname
          email
        }
      }
      """

      expected_response = %{
        "data" => %{"user" => %{"nickname" => "Raul", "email" => "raul@mail.com"}}
      }

      response =
        ctx.conn
        |> post("/api/graphql", %{query: query})
        |> json_response(200)

      assert response == expected_response
    end

    test "when where is an error, returns the error", ctx do
      query = """
      {
        user(id: 999){
          nickname
          email
        }
      }
      """

      expected_response = %{
        "data" => %{"user" => nil},
        "errors" => [
          %{
            "locations" => [%{"column" => 3, "line" => 2}],
            "message" => "not_found",
            "path" => ["user"]
          }
        ]
      }

      response =
        ctx.conn
        |> post("/api/graphql", %{query: query})
        |> json_response(200)

      assert response == expected_response
    end
  end

  describe "users mutation" do
    test "when all params are valid, creates the user", ctx do
      query = """
      mutation{
        createUser(input: {nickname: "Raul", email: "raul@mail.com", age: 43}){
          id
          nickname
          age
        }
      }
      """

      response =
        ctx.conn
        |> post("/api/graphql", %{query: query})
        |> json_response(200)

      assert %{
               "data" => %{"createUser" => %{"id" => _, "nickname" => "Raul", "age" => 43}}
             } = response
    end
  end

  describe "subscriptions" do
    test "new follow", ctx do
      {:ok, user_1} = Twix.create_user(%{nickname: "Raul-1", age: 43, email: "raul-1@mail.com"})
      {:ok, user_2} = Twix.create_user(%{nickname: "Raul-2", age: 43, email: "raul-2@mail.com"})

      subscription_query = """
      subscription{
        newFollow{
          followerId
          followingId
        }
      }
      """

      subscription_id = subscribe(ctx.socket, subscription_query)

      mutation_query = """
      mutation{
        addFollower(input: {userId: #{user_1.id}, followerId: #{user_2.id}}){
          followerId
          followingId
        }
      }
      """

      ref = push_doc(ctx.socket, mutation_query)
      assert_reply ref, :ok, reply_response

      assert_push "subscription:data", push_response

      expected_follower = %{
        "followingId" => "#{user_1.id}",
        "followerId" => "#{user_2.id}"
      }

      assert reply_response == %{data: %{"addFollower" => expected_follower}}

      assert push_response == %{
               result: %{data: %{"newFollow" => expected_follower}},
               subscriptionId: subscription_id
             }
    end
  end
end

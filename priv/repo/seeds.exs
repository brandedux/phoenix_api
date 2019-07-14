# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     MyApp.Repo.insert!(%MyApp.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

# Create seed for user authentication
%MyApp.Users.User{}
|> MyApp.Users.User.changeset(%{
  email: "testuser@example.com",
  password: "secret1234",
  confirm_password: "secret1234"
})
|> MyApp.Repo.insert!()

# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# It is also run when you use the command `mix ecto.setup`
#

users = [
  %{email: "ted@example.com", password: "password"},
  %{email: "eddiebaby@example.com", password: "password"}
]

for user <- users do
  {:ok, user} = ForksTheEggSample.Accounts.create_user(user)
  ForksTheEggSample.Accounts.confirm_user(user)
end

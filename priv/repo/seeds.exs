# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     BidirectionalScroll.Repo.insert!(%BidirectionalScroll.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias BidirectionalScroll.Alerts

Enum.each(1..30, fn _ ->
  {:ok, _} =
    Alerts.create_alert(%{
      started_at: DateTime.utc_now(),
      resolved_at: DateTime.utc_now() |> DateTime.add(15)
    })
end)

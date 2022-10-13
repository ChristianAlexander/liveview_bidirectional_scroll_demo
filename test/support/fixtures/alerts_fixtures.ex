defmodule BidirectionalScroll.AlertsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BidirectionalScroll.Alerts` context.
  """

  @doc """
  Generate a alert.
  """
  def alert_fixture(attrs \\ %{}) do
    {:ok, alert} =
      attrs
      |> Enum.into(%{
        resolved_at: ~N[2022-10-12 13:37:00.000000],
        started_at: ~N[2022-10-12 13:37:00.000000]
      })
      |> BidirectionalScroll.Alerts.create_alert()

    alert
  end
end

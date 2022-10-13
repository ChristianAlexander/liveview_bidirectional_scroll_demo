defmodule BidirectionalScroll.AlertPublisher do
  use GenServer

  require Logger

  alias BidirectionalScroll.Alerts

  def start_link(_state), do: GenServer.start_link(__MODULE__, nil, name: __MODULE__)

  @impl GenServer
  def init(state) do
    {:ok, state, 0}
  end

  @impl GenServer
  def handle_info(:timeout, _) do
    latest_alert = Alerts.list_alerts(limit: 1) |> Enum.at(0)

    case latest_alert do
      nil ->
        create_alert()

      %{resolved_at: nil} = alert ->
        resolve_alert(alert)

      _alert ->
        create_alert()
    end

    # Loop, waiting a random duration up to 5,000 ms between iterations
    timeout = :rand.uniform(5_000)

    {:noreply, nil, timeout}
  end

  # Creates an unresolved alert
  defp create_alert() do
    Logger.info("Creating new alert")
    {:ok, alert} = Alerts.create_alert(%{started_at: DateTime.utc_now()})

    Phoenix.PubSub.broadcast(BidirectionalScroll.PubSub, "alerts", {:alert_created, alert})
  end

  defp resolve_alert(alert) do
    Logger.info("Resolving alert #{alert.id}")
    {:ok, alert} = Alerts.update_alert(alert, %{resolved_at: DateTime.utc_now()})

    Phoenix.PubSub.broadcast(BidirectionalScroll.PubSub, "alerts", {:alert_updated, alert})
  end
end

defmodule BidirectionalScrollWeb.Live.ScrollDemoLive do
  use BidirectionalScrollWeb, :live_view

  alias BidirectionalScroll.Alerts

  def mount(_params, _session, socket) do
    if connected?(socket) do
      Phoenix.PubSub.subscribe(BidirectionalScroll.PubSub, "alerts")
    end

    alerts = Alerts.list_alerts(limit: 5)

    oldest_loaded_alert = Enum.min_by(alerts, & &1.started_at, NaiveDateTime)

    socket =
      assign(socket,
        alerts: alerts,
        oldest_alert_started_at: oldest_loaded_alert.started_at,
        update_direction: "append"
      )

    {:ok, socket, temporary_assigns: [alerts: []]}
  end

  def handle_info({:alert_created, alert}, socket) do
    socket =
      assign(socket,
        alerts: [alert],
        update_direction: "prepend"
      )

    {:noreply, socket}
  end

  def handle_info({:alert_updated, alert}, socket) do
    socket =
      assign(socket,
        alerts: [alert],
        update_direction: "prepend"
      )

    {:noreply, socket}
  end

  def handle_event("load-more", _value, socket) do
    oldest_alert_started_at = socket.assigns.oldest_alert_started_at

    alerts = Alerts.list_alerts(started_before: oldest_alert_started_at, limit: 5)
    oldest_loaded_alert = Enum.min_by(alerts, & &1.started_at, NaiveDateTime)

    socket =
      assign(socket,
        alerts: alerts,
        oldest_alert_started_at: oldest_loaded_alert.started_at,
        update_direction: "append"
      )

    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
    <h1>Alerts</h1>
    <table>
      <thead>
        <tr>
          <th>ID</th>
          <th>Started At</th>
          <th>Resolved At</th>
        </tr>
      </thead>
      <tbody id="alert-list" phx-update={@update_direction}>
        <tr :for={alert <- @alerts} id={"alert-#{alert.id}"} >
          <td><%= alert.id %></td>
          <td><%= alert.started_at %></td>
          <td><%= alert.resolved_at %></td>
        </tr>
      </tbody>
    </table>
    <button id="alerts-load-more" phx-hook="InfiniteScrollButton" phx-click="load-more">Load More</button>
    """
  end
end

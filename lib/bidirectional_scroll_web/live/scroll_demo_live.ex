defmodule BidirectionalScrollWeb.Live.ScrollDemoLive do
  use BidirectionalScrollWeb, :live_view

  alias BidirectionalScroll.Alerts

  def mount(_params, _session, socket) do
    alerts = Alerts.list_alerts(limit: 5)

    socket = assign(socket, alerts: alerts)

    {:ok, socket}
  end

  def handle_event("load-more", _value, socket) do
    alerts = socket.assigns.alerts

    oldest_loaded_alert = Enum.min_by(alerts, & &1.started_at, NaiveDateTime)
    older_alerts = Alerts.list_alerts(started_before: oldest_loaded_alert.started_at, limit: 5)

    alerts = alerts ++ older_alerts
    socket = assign(socket, alerts: alerts)

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
      <tbody>
        <%= for alert <- @alerts do %>
          <tr>
            <td><%= alert.id %></td>
            <td><%= alert.started_at %></td>
            <td><%= alert.resolved_at %></td>
          </tr>
        <% end %>
      </tbody>
    </table>
    <button phx-click="load-more">Load More</button>
    """
  end
end

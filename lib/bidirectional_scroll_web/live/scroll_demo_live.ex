defmodule BidirectionalScrollWeb.Live.ScrollDemoLive do
  use BidirectionalScrollWeb, :live_view

  alias BidirectionalScroll.Alerts

  def mount(_params, _session, socket) do
    alerts = Alerts.list_alerts(limit: 5)

    socket = assign(socket, alerts: alerts)

    {:ok, socket}
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
    """
  end
end

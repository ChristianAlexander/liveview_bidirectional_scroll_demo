defmodule BidirectionalScroll.AlertsTest do
  use BidirectionalScroll.DataCase

  alias BidirectionalScroll.Alerts

  describe "alerts" do
    alias BidirectionalScroll.Alerts.Alert

    import BidirectionalScroll.AlertsFixtures

    @invalid_attrs %{resolved_at: nil, started_at: nil}

    test "list_alerts/0 returns all alerts" do
      alert = alert_fixture()
      assert Alerts.list_alerts() == [alert]
    end

    test "get_alert!/1 returns the alert with given id" do
      alert = alert_fixture()
      assert Alerts.get_alert!(alert.id) == alert
    end

    test "create_alert/1 with valid data creates a alert" do
      valid_attrs = %{resolved_at: ~N[2022-10-12 13:37:00.000000], started_at: ~N[2022-10-12 13:37:00.000000]}

      assert {:ok, %Alert{} = alert} = Alerts.create_alert(valid_attrs)
      assert alert.resolved_at == ~N[2022-10-12 13:37:00.000000]
      assert alert.started_at == ~N[2022-10-12 13:37:00.000000]
    end

    test "create_alert/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Alerts.create_alert(@invalid_attrs)
    end

    test "update_alert/2 with valid data updates the alert" do
      alert = alert_fixture()
      update_attrs = %{resolved_at: ~N[2022-10-13 13:37:00.000000], started_at: ~N[2022-10-13 13:37:00.000000]}

      assert {:ok, %Alert{} = alert} = Alerts.update_alert(alert, update_attrs)
      assert alert.resolved_at == ~N[2022-10-13 13:37:00.000000]
      assert alert.started_at == ~N[2022-10-13 13:37:00.000000]
    end

    test "update_alert/2 with invalid data returns error changeset" do
      alert = alert_fixture()
      assert {:error, %Ecto.Changeset{}} = Alerts.update_alert(alert, @invalid_attrs)
      assert alert == Alerts.get_alert!(alert.id)
    end

    test "delete_alert/1 deletes the alert" do
      alert = alert_fixture()
      assert {:ok, %Alert{}} = Alerts.delete_alert(alert)
      assert_raise Ecto.NoResultsError, fn -> Alerts.get_alert!(alert.id) end
    end

    test "change_alert/1 returns a alert changeset" do
      alert = alert_fixture()
      assert %Ecto.Changeset{} = Alerts.change_alert(alert)
    end
  end
end

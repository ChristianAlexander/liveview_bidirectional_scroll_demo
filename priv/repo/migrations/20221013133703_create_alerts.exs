defmodule BidirectionalScroll.Repo.Migrations.CreateAlerts do
  use Ecto.Migration

  def change do
    create table(:alerts) do
      add :started_at, :naive_datetime_usec
      add :resolved_at, :naive_datetime_usec

      timestamps()
    end
  end
end

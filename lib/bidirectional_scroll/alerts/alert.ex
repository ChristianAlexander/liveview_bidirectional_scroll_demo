defmodule BidirectionalScroll.Alerts.Alert do
  use Ecto.Schema
  import Ecto.Changeset

  schema "alerts" do
    field :resolved_at, :naive_datetime_usec
    field :started_at, :naive_datetime_usec

    timestamps()
  end

  @doc false
  def changeset(alert, attrs) do
    alert
    |> cast(attrs, [:started_at, :resolved_at])
    |> validate_required([:started_at])
  end
end

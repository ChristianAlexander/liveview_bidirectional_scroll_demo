defmodule BidirectionalScroll.Alerts do
  @moduledoc """
  The Alerts context.
  """

  import Ecto.Query, warn: false
  alias BidirectionalScroll.Repo

  alias BidirectionalScroll.Alerts.Alert

  @doc """
  Returns the list of alerts.

  ## Examples

      iex> list_alerts()
      [%Alert{}, ...]

  """
  def list_alerts do
    list_alerts([])
  end

  def list_alerts(criteria) when is_list(criteria) do
    query = from(p in Alert, order_by: [desc: :started_at])

    Enum.reduce(criteria, query, fn
      {:started_before, started_before}, query when not is_nil(started_before) ->
        from(q in query, where: q.started_at < ^started_before)

      {:limit, limit}, query ->
        from(q in query, limit: ^limit)

      _, query ->
        query
    end)
    |> Repo.all()
  end

  @doc """
  Gets a single alert.

  Raises `Ecto.NoResultsError` if the Alert does not exist.

  ## Examples

      iex> get_alert!(123)
      %Alert{}

      iex> get_alert!(456)
      ** (Ecto.NoResultsError)

  """
  def get_alert!(id), do: Repo.get!(Alert, id)

  @doc """
  Creates a alert.

  ## Examples

      iex> create_alert(%{field: value})
      {:ok, %Alert{}}

      iex> create_alert(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_alert(attrs \\ %{}) do
    %Alert{}
    |> Alert.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a alert.

  ## Examples

      iex> update_alert(alert, %{field: new_value})
      {:ok, %Alert{}}

      iex> update_alert(alert, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_alert(%Alert{} = alert, attrs) do
    alert
    |> Alert.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a alert.

  ## Examples

      iex> delete_alert(alert)
      {:ok, %Alert{}}

      iex> delete_alert(alert)
      {:error, %Ecto.Changeset{}}

  """
  def delete_alert(%Alert{} = alert) do
    Repo.delete(alert)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking alert changes.

  ## Examples

      iex> change_alert(alert)
      %Ecto.Changeset{data: %Alert{}}

  """
  def change_alert(%Alert{} = alert, attrs \\ %{}) do
    Alert.changeset(alert, attrs)
  end
end

defmodule BidirectionalScroll.Repo do
  use Ecto.Repo,
    otp_app: :bidirectional_scroll,
    adapter: Ecto.Adapters.SQLite3
end

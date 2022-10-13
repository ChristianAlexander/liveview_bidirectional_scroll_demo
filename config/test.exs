import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :bidirectional_scroll, BidirectionalScroll.Repo,
  database: Path.expand("../bidirectional_scroll_test.db", Path.dirname(__ENV__.file)),
  pool_size: 5,
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :bidirectional_scroll, BidirectionalScrollWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "/Qg75Gx3sH7zAwlSKHhX4bp2IN+KTzOxDbXLCXz1VbbfJ96qwsgwJOJekyr66HcR",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

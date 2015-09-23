# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :demo_phoenix_oauth, DemoPhoenixOauth.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "I0BOQLrb7gOh3ItcX6c/+UW/+cR+T9d7PF/hL1QUh+aDQkJE+m00vEJDJYMA9Xl6",
  render_errors: [accepts: ["json"]],
  pubsub: [name: DemoPhoenixOauth.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

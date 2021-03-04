# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :curso_elixir_db,
  ecto_repos: [CursoElixirDb.Repo]

# Configures the endpoint
config :curso_elixir_db, CursoElixirDbWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "+wJoDillDuFcueXxE7A1TiCkU4sZYBjXnzoPbNMrNkLwLz4zMh9C4iPGML3dU7hu",
  render_errors: [view: CursoElixirDbWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: CursoElixirDb.PubSub,
  live_view: [signing_salt: "twgw5iQy"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :logger, level: :debug

config :curso_elixir_db, CursoElixirDb.Scheduler,
  jobs: [
    # application_task: [
    #   schedule: {:extended, "* * * * *"},
    #   task: {JobQuantum, :print_text, ["tmp/increment.txt", "Hola "]}
    # ],
    # application_task_insert: [
    #   schedule: {:extended, "*/3 * * * *"},
    #   task: {JobQuantum, :insert_data, []}
    # ],

    application_scraping: [
      schedule: {:extended, "*/20 * * * *"},
      task: {Scrap, :do_get, []}
    ]
 ]

 config :curso_elixir_db, CursoElixirDb.Endpoint,
   live_view: [signing_salt: "8i1D6nZCH6l4oiQ2mZaxYDYzKt1toIy6"]

#  config :floki, :html_parser, Floki.HTMLParser.Html5ever

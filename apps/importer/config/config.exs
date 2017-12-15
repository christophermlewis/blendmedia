# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :importer, :ecto_repos, [Importer.CrimeRepo] 
config :importer, Importer.CrimeRepo,
  adapter: Ecto.Adapters.Postgres,
  url: System.get_env("DATABASE_URL")
config :logger, level: :debug

#import_config "#{Mix.env}.exs"

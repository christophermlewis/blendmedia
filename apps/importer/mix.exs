defmodule Importer.Mixfile do
  use Mix.Project

  def project do
    [
      app: :importer,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Importer.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
#{:moebius, "~> 3.0.1"}
      {:postgrex, ">= 0.0.0"},
      {:ecto, "~> 2.1"},
      {:poison, "~> 3.1"}
    ]
  end
end

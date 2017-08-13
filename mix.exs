defmodule Census.Mixfile do
  use Mix.Project

  def project do
    [
      app: :census,
      name: "Census",
      description: "Elixir library for interacting with api.census.gov",
      version: "0.1.4",
      elixir: "~> 1.4",
      source_url: "https://github.com/rockwood/census",
      elixirc_paths: elixirc_paths(Mix.env),
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps(),
      docs: docs(),
      package: package()
    ]
  end

  def application do
    [applications: [:logger, :httpoison]]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.16", only: :dev},
      {:poison, "~> 3.1"},
      {:httpoison, "~> 0.12"},
      {:dialyxir, "~> 0.5", only: [:dev]}
    ]
  end

  def docs do
    [main: "readme", extras: ["README.md"]]
  end

  def package do
    [
      name: :census,
      maintainers: ["Kevin Rockwood"],
      licenses: ["Apache 2.0"],
      links: %{
        "GitHub" => "https://github.com/rockwood/census"
      }
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]
end

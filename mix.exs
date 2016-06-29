defmodule Census.Mixfile do
  use Mix.Project

  def project do
    [
      app: :census,
      name: "Census",
      description: "Elixir library for interacting with api.census.gov",
      version: "0.1.0",
      elixir: "~> 1.3",
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
      {:ex_doc, "~> 0.12", only: :dev},
      {:poison, "~> 2.0"},
      {:httpoison, "~> 0.9.0"}
    ]
  end

  def docs do
    [main: "README", extras: ["README.md"]]
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

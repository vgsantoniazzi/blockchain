defmodule Coin.MixProject do
  use Mix.Project

  def project do
    [
      app: :coin,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:poison, "~> 3.1"},
      {:ex_cli, "~> 0.1.0"}
    ]
  end
end

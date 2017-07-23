defmodule TwilightInformant.Mixfile do
  use Mix.Project

  def project do
    [app: :twilight_informant,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [extra_applications: [:logger, :httpoison]]
  end

  def deps do
    [{:httpoison, "~> 0.12"},
     {:poison, "~> 3.1"},
     {:timex, "~> 3.0"}]
  end
end

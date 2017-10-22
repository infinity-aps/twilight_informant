defmodule TwilightInformant.Mixfile do
  use Mix.Project

  def project do
    [app: :twilight_informant,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     name: "Twilight Informant",
     source_url: "https://github.com/infinity-aps/twilight_informant",
     description: description(),
     package: package()]
  end

  def application do
    [extra_applications: [:logger, :httpoison]]
  end

  def deps do
    [{:httpoison, "~> 0.12"},
     {:poison, "~> 3.1"},
     {:timex, "~> 3.0"}]
  end

  defp description do
    """
    Twilight Informant is an Elixir client for the Nightscout (cgm-remote-monitor) JSON API.
    """
  end

  defp package do
    [
      maintainers: ["Timothy Mecklem"],
      licenses: ["MIT License"],
      links: %{"Github" => "https://github.com/infinity-aps/twilight_informant"}
    ]
  end
end

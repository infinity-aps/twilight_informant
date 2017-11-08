defmodule TwilightInformant do
  alias TwilightInformant.HTTP
  @moduledoc """
  TwilightInformant provides an HTTP Elixir interface to the NightScout API.

  ## Usage


  Add it to your applications and dependencies in `mix.exs`:

      def application do
        [applications: [:twilight_informant]]
      end

      def deps do
        [{:twilight_informant, "~> 0.1"}]
      end

  Configure it in `config.exs`:

      config :twilight_informant,
        ns_url: "xxxxxx", # defaults to System.get_env("NS_URL")
        api_secret: "xxxxxx", # defaults to System.get_env("API_SECRET")
        httpoison_opts: [], # defaults to []

  Then use functions like:

      {:ok, status} = TwilightInformant.status()
      {:ok, profile} = TwilightInformant.profile()
      {:ok, entries} = TwilightInformant.entries(200)

  status, profile and entries are Maps converted from the JSON response from the Nightscout server.
  """
  use Application

  def start(_type, _args) do
    ns_url = Application.get_env(:twilight_informant, :ns_url, System.get_env("NS_URL"))
    api_secret = Application.get_env(:twilight_informant, :api_secret, System.get_env("API_SECRET"))
    httpoison_opts = Application.get_env(:twilight_informant, :httpoison_opts, [])

    config = %{
      ns_url: ns_url,
      api_secret: api_secret,
      httpoison_opts: httpoison_opts
    }
    Agent.start_link(fn -> config end, name: __MODULE__)
  end

  @doc """
  Returns the count last entries.
  """
  def entries(count) do
    query("entries", count: count)
  end

  @doc """
  Returns the server side status, default settings and capabilities.
  """
  def status() do
    query("status")
  end

  @doc """
  Returns information about the Nightscout treatment profiles.
  """
  def profile() do
    query("profile")
  end

  defp query(path, params \\ []) do
    HTTP.get(path <> ".json?" <> "token=" <> api_secret() <> URI.encode_query(params))
  end

  @doc false
  def url() do
    Agent.get(__MODULE__, fn(state) -> state.ns_url <> "/api/v1/" end)
  end

  @doc false
  def httpoison_opts() do
    Agent.get(__MODULE__, fn(state) -> state.httpoison_opts end)
  end

  @doc false
  def api_secret() do
    Agent.get(__MODULE__, fn(state) -> state.api_secret end)
  end
end

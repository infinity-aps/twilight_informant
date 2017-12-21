defmodule TwilightInformant do
  alias TwilightInformant.HTTP
  @moduledoc """
  TwilightInformant provides an HTTP Elixir interface to the Nightscout API.

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
      {:ok, entries} = TwilightInformant.entries(count: 200)

  status, profile and entries are Maps converted from the JSON response from the Nightscout server.
  """

  @doc """
  Returns entries. More concrete queries can be made with query_params.
  For example:
      TwilightInformant.entries(count: 200)
  """
  def entries(query_params \\ []) do
    HTTP.get("entries", query_params)
  end

  @doc """
  Returns treatments. More concrete queries can be made with query_params.
  """
  def treatments(query_params \\ []) do
    HTTP.get("treatments", query_params)
  end

  @doc """
  Writes entries to the server.
  """
  def post_entries(entries) do
    HTTP.post("entries", entries)
  end

  @doc """
  Writes treatments to the server.
  """
  def post_treatments(treatments) do
    HTTP.post("treatments", treatments)
  end

  @doc """
  Returns the server side status, default settings and capabilities.
  """
  def status() do
    HTTP.get("status")
  end

  @doc """
  Returns the threshold settings.
  """
  def thresholds() do
    case status() do
      {:ok, %{"settings" => %{"thresholds" => thresholds}} = response} ->
        thresholds
      other -> other
    end
  end

  @doc """
  Returns information about the Nightscout treatment profiles.
  """
  def profile() do
    HTTP.get("profile")
  end

end

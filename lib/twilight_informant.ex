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

  @doc """
  Returns the count last entries.
  """
  def entries(count) do
    HTTP.get("entries", count: count)
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
      {:ok, response} ->
        %{"settings" => %{"thresholds" => thresholds}} = response
        thresholds
      {:ok, response, status_code} ->
        {:ok, response, status_code}
      {:error, %{reason: reason}} ->
        {:error, %{reason: reason}}
    end
  end

  @doc """
  Returns the server side status, default settings and capabilities.
  """
  def treatments() do
    HTTP.get("treatments")
  end

  @doc """
  Returns information about the Nightscout treatment profiles.
  """
  def profile() do
    HTTP.get("profile")
  end

end

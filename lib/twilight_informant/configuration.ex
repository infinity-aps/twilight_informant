defmodule TwilightInformant.Configuration do
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

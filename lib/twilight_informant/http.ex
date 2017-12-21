defmodule TwilightInformant.HTTP do
  alias TwilightInformant.Configuration

  @headers ["Content-Type": "application/json"]

  @doc """
  Issues GET HTTP requests.

  Args:
    # path - the JSON api path that adds up to the URL
    # query_params - keyword list with query parameters given by the user
  """
  def get(path, query_params \\ []) do
    call(path, :get, "", query_params)
  end

  @doc """
  Issues POST HTTP requests.

  Args:
    # path - the JSON api path that adds up to the URL
    # body - a Map with the information to write to the server
    # query_params - keyword list with query parameters given by the user
  """
  def post(path, body, query_params \\ []) do
    {:ok, encoded} = Poison.encode(body)
    call(path, :post, encoded, query_params)
  end

  @doc """
  General function that issues the HTTP request.

  Args:
    # path - the JSON api path that adds up to the URL
    # method - it can be :get (read) or :post (write)
    # body - JSON encoded information to write to the server
    # query_params - keyword list with query parameters given by the user
  """
  def call(path, method, body \\ "", query_params \\ []) do
    HTTPoison.request(
       method,
       path |> build_url,
       body,
       @headers,
       [params: query_params |> add_api_token] |> add_httpoison_opts)
       |> handle_response
  end

  @doc false
  defp handle_response(response) do
    case response do
      {:ok, %HTTPoison.Response{status_code: status_code} = response} when status_code in 200..299 ->
        {:ok, Poison.decode!(response.body)}
      {:ok, %HTTPoison.Response{status_code: status_code} = response} when status_code in 400..599 ->
        {:ok, Poison.decode!(response.body), status_code}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, %{reason: reason}}
    end
  end

  @doc false
  defp build_url(path) do
    Configuration.url() <> path <> ".json"
  end

  @doc false
  defp add_httpoison_opts(params) do
    Keyword.merge(params, Configuration.httpoison_opts())
  end

  @doc false
  defp add_api_token(params) do
    Keyword.merge(params, token: Configuration.api_secret())
  end
end

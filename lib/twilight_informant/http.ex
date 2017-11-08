defmodule TwilightInformant.HTTP do
  @headers ["Content-Type": "application/json"]

  def get(endpoint) do
    url = TwilightInformant.url()
    opts = TwilightInformant.httpoison_opts()
    HTTPoison.get(url <> endpoint, @headers, opts)
    |> handle_response()
  end

  defp handle_response(response) do
    case response do
      {:ok, %HTTPoison.Response{status_code: status_code} = response} when status_code in 200..299 ->
        {:ok, Poison.decode!(response.body)}
      {:ok, %HTTPoison.Response{status_code: status_code} = response} when status_code in 400..599 ->
        {:ok, Poison.decode!(response.body)}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, %{reason: reason}}
    end
  end
end

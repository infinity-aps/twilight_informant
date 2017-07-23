defmodule TwilightInformant.Entry do
  # see https://github.com/nightscout/cgm-remote-monitor/blob/master/swagger.yaml
  defstruct type: nil, dateString: nil, date: nil, sgv: nil, direction: nil,
    noise: nil, filtered: nil, unfiltered: nil, rssi: nil, device: nil

  @content_type {"Content-Type", "application/json"}
  def post(entries, ns_url) do
    case Poison.encode(entries) do
      {:ok, body} -> HTTPoison.post(ns_url, body, [@content_type])
      other       -> other
    end
  end

  @minutes_back 1440
  def gaps(ns_url, minutes_back \\ @minutes_back) do
    minutes_ago = Timex.now |> Timex.shift(minutes: -minutes_back) |> DateTime.to_unix(:milliseconds)
    params = "&find[date][$gte]=#{minutes_ago}&count=1000"
    url = "#{ns_url}#{params}"
    with {:ok, response} <- HTTPoison.get(url, [@content_type]),
         {:ok, entries} <- Poison.decode(response.body) do
      count_gaps(entries)
    else
      other -> IO.inspect other
    end
  end

  defp count_gaps([]), do: []
  defp count_gaps(entries) do
    _count_gaps(entries, Timex.now(), [])
  end

  defp _count_gaps([], _, gaps), do: gaps
  defp _count_gaps([%{"dateString" => dateString} | rest], gap_end, gaps) do
    gap_start = Timex.parse!(dateString, "{ISO:Extended}")
    gap_threshold = Timex.shift(gap_end, minutes: -6)
    case Timex.before?(gap_start, gap_threshold) do
      true ->
        _count_gaps(rest, gap_start, [%{gap_start: gap_start, gap_end: gap_end} | gaps])
      _ ->
        _count_gaps(rest, gap_start, gaps)
    end
  end
end

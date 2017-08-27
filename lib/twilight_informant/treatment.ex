defmodule TwilightInformant.Treatment do
  # see https://github.com/nightscout/cgm-remote-monitor/blob/master/swagger.yaml
  defstruct created_at: nil, eventType: nil, glucose: nil, glucoseType: nil, carbs: nil, insulin: nil,
            units: nil, notes: nil, enteredBy: "NervesAPS", timestamp: nil, _type: nil

  @content_type {"Content-Type", "application/json"}
  def post(treatments, ns_url) do
    case Poison.encode(treatments) do
      {:ok, body} -> HTTPoison.post(ns_url, body, [@content_type])
      other       -> other
    end
  end
end

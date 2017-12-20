defmodule TwilightInformantTest do
  use ExUnit.Case
  doctest TwilightInformant

  test "get status" do
    entry = %{"_id" => "5a33b299f92af0e8d0f898ee", "date" => 1513337384000,
              "dateString" => "2017-12-15T06:29:44-05:00", "device" => "share2",
              "direction" => "Flat", "glucose" => 93, "sgv" => 93, "trend" => 4,
              "type" => "sgv"}
    treatment = %{"_type" => "TempBasalDuration", "_description" => "TempBasalDuration 2017-12-15T06:23:01 head[2], body[0] op[0x16]",
                   "timestamp" => "2017-12-15T06:23:01-05:00", "_body" => "",
                   "_head" => "1601", "duration (min)" => 30, "_date" => "c117064f11"}
    #assert {:ok, _answer} = TwilightInformant.post_treatments(treatment)
    assert {:ok, _answer} = TwilightInformant.post_entries(entry)
    #assert {:ok, _status} = TwilightInformant.status()
    assert {:ok, _entries} = TwilightInformant.entries()
  end
end

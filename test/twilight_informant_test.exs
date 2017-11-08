defmodule TwilightInformantTest do
  use ExUnit.Case
  doctest TwilightInformant

  test "get status" do
    assert {:ok, _status} = TwilightInformant.status()
    assert {:ok, _entries} = TwilightInformant.entries(200)
  end
end

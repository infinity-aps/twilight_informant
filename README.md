# TwilightInformant

Twilight Informant is an Elixir client for the Nightscout JSON API. Nightscout is a web-based continuous glucose monitor
and for many people is the iconic face of closed looping (more information
[here(https://github.com/nightscout/cgm-remote-monitor)]).

## Project Goals

This project aims to provide a complete Elixir client interface to the Nightscout API documented by
its [swagger.yaml specification](https://github.com/nightscout/cgm-remote-monitor/blob/master/swagger.yaml).
Specifically, this client will be able to act as a cgm to a closed loop by searching and fetching from Nightscout's CGM
`entries`. Additionally, the client will support posting CGM `entries` along with pump history in the form of
`treatments` and other status information such as battery level and looping algorithm data.

Goal Progress:

- [ ] Read last x minutes of CGM `entries` from Nightscout
- [ ] Read target bg range from Nightscout
- [ ] Write `entries` to Nightscout
- [ ] Write `treatments` to Nighscout
- [ ] report loop, battery, and profile status to Nightscout

## Installation

The package can be installed by adding `twilight_informant` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:twilight_informant, "~> 0.1.0"}]
end
```

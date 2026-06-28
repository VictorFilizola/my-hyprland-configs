#!/bin/bash

# Waybar media module — MPRIS with PipeWire fallback
# - MPRIS Playing: show artist/song with animated eq (via media-writer)
# - MPRIS Paused: show pause icon + track (ignores PipeWire)
# - No MPRIS: fall back to PipeWire audio streams
# - Nothing: empty (hidden)

status=$(playerctl status 2>/dev/null)

# Helper: get track name from MPRIS metadata
get_track() {
  artist=$(playerctl metadata artist 2>/dev/null)
  title=$(playerctl metadata title 2>/dev/null)
  if [ -n "$artist" ]; then
    echo "$artist"
  elif [ -n "$title" ]; then
    echo "$title"
  else
    echo ""
  fi
}

# Helper: get most recent PipeWire audio stream name
pw_app() {
  pw-dump 2>/dev/null \
    | jq -r '[.[] | select(.info.props."media.class" == "Stream/Output/Audio")] | if length == 0 then "" else max_by(.id) | .info.props."application.name" // .info.props."node.description" // "" end' 2>/dev/null
}

# Helper: format and output PipeWire state
output_pw() {
  local app="$1"
  if [ -n "$app" ] && [ "$app" != "null" ]; then
    text="  $app"
    if [ ${#text} -gt 80 ]; then text="${text:0:77}..."; fi
    printf '{"text": "%s", "class": "pw-stream"}\n' "$text"
  else
    printf '{"text": "", "class": "stopped"}\n'
  fi
}

# --- Playing ---
if [ "$status" = "Playing" ]; then
  track=$(get_track)
  if [ -z "$track" ]; then track="Unknown"; fi
  if [ ${#track} -gt 80 ]; then track="${track:0:77}..."; fi
  printf '{"text": "%s", "class": "playing"}\n' "  $track"
  exit 0
fi

# --- Paused ---
# Some players (Brave) set status="Paused"; others clear status on pause.
# Detect paused state: status=Paused, or status empty but MPRIS metadata exists.
if [ "$status" = "Paused" ] || ([ -z "$status" ] && [ -n "$(playerctl metadata title 2>/dev/null)" ]); then
  track=$(get_track)
  if [ -z "$track" ]; then track="Unknown"; fi
  if [ ${#track} -gt 80 ]; then track="${track:0:77}..."; fi
  printf '{"text": "%s", "class": "paused"}\n' "󰏤  $track"
  exit 0
fi

# --- No MPRIS at all — fall back to PipeWire ---
output_pw "$(pw_app)"

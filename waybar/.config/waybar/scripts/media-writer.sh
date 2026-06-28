#!/bin/bash

# background media state writer — updates /tmp/waybar-media.json at 100ms
# waybar reads this file each tick for near-realtime animation

OUTFILE="/tmp/waybar-media.json"
frames=("▁▂▃▄▅▆▇" "▂▃▄▅▆▇▁" "▃▄▅▆▇▁▂" "▄▅▆▇▁▂▃" "▅▆▇▁▂▃▄" "▆▇▁▂▃▄▅" "▇▁▂▃▄▅▆")
frlen=${#frames[@]}
tick=0

while true; do
  status=$(playerctl status 2>/dev/null)

  # Detect paused: status=Paused, or status empty but metadata exists (Brave quirk)
  if [ "$status" = "Paused" ] || ([ -z "$status" ] && [ -n "$(playerctl metadata title 2>/dev/null)" ]); then
    status="Paused"
  elif [ -z "$status" ]; then
    echo '{"text": "", "class": "stopped"}' >"$OUTFILE"
    sleep 0.5
    tick=0
    continue
  fi

  artist=$(playerctl metadata artist 2>/dev/null)
  title=$(playerctl metadata title 2>/dev/null)

  if [ -n "$artist" ] && [ -n "$title" ]; then
    track="$artist — $title"
  elif [ -n "$title" ]; then
    track="$title"
  else
    track="Unknown"
  fi

  if [ ${#track} -gt 55 ]; then
    track="${track:0:52}..."
  fi

  case "$status" in
  Playing)
    eq="${frames[$tick]}"
    tick=$(((tick + 1) % frlen))
    text="$eq  $track"
    echo "{\"text\": \"$text\", \"class\": \"playing\"}" >"$OUTFILE"
    sleep 0.1
    ;;
  Paused)
    text="󰏤  $track"
    echo "{\"text\": \"$text\", \"class\": \"paused\"}" >"$OUTFILE"
    sleep 0.5
    tick=0
    ;;
  *)
    echo '{"text": "", "class": "stopped"}' >"$OUTFILE"
    sleep 0.5
    tick=0
    ;;
  esac
done

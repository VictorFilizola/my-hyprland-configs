#!/bin/bash
# CPU usage (two-sample /proc/stat)
cpu1=($(head -1 /proc/stat))
sleep 0.5
cpu2=($(head -1 /proc/stat))

idle1=${cpu1[4]}
total1=$((cpu1[1] + cpu1[2] + cpu1[3] + cpu1[4] + cpu1[5] + cpu1[6] + cpu1[7]))
idle2=${cpu2[4]}
total2=$((cpu2[1] + cpu2[2] + cpu2[3] + cpu2[4] + cpu2[5] + cpu2[6] + cpu2[7]))

idle_diff=$((idle2 - idle1))
total_diff=$((total2 - total1))
cpu_usage=$((100 * (total_diff - idle_diff) / total_diff))

# CPU temperature
cpu_temp=$(($(cat /sys/class/hwmon/hwmon2/temp1_input) / 1000))

printf " %d%%  %d°C\n" "$cpu_usage" "$cpu_temp"

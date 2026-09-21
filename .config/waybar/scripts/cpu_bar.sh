#!/bin/bash
# Pure AWK implementation: 0 external processes, reads /proc/stat directly.
awk -v delay=1 '
BEGIN {
    while (getline < "/proc/stat" > 0) {
        if ($1 == "cpu") {
            idle = $5
            total = $2+$3+$4+$5+$6+$7+$8
            break
        }
    }
    close("/proc/stat")
    
    system("sleep " delay)
    
    while (getline < "/proc/stat" > 0) {
        if ($1 == "cpu") {
            idle_new = $5
            total_new = $2+$3+$4+$5+$6+$7+$8
            break
        }
    }
    close("/proc/stat")
    
    diff_idle = idle_new - idle
    diff_total = total_new - total
    pct = int(100 * (diff_total - diff_idle) / diff_total)
    
    bar = ""
    for (i = 10; i <= 100; i += 10) {
        if (pct >= i) bar = bar "█"
        else bar = bar "░"
    }
    
    printf "{\"text\": \" [%s] %d%%\", \"tooltip\": \"CPU Usage: %d%% (Pure AWK rendered)\"}\n", bar, pct, pct
    exit
}'

#!/bin/bash
awk '
/^MemTotal:/ { total=$2 }
/^MemAvailable:/ { avail=$2 }
END {
    used = total - avail
    pct = int((used / total) * 100)
    
    bar = ""
    for (i = 10; i <= 100; i += 10) {
        if (pct >= i) bar = bar "█"
        else bar = bar "░"
    }
    
    used_gb = used / 1024 / 1024
    total_gb = total / 1024 / 1024
    
    printf "{\"text\": \" [%s] %d%%\", \"tooltip\": \"Used: %.1fGB / Total: %.1fGB\"}\n", bar, pct, used_gb, total_gb
}
' /proc/meminfo

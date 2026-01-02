#!/bin/bash

wait_with_progress() {
    local total_seconds="$1"
    local message="${2:-Processing}"
    
    echo "$message..."
    
    for ((i=1; i<=total_seconds; i++)); do
        # Calculate progress percentage
        local percent=$((i * 100 / total_seconds))
        local filled=$((percent / 2))  # 50 chars max
        
        # Create progress bar
        printf "\r["
        printf "%*s" "$filled" | tr ' ' '='
        printf "%*s" $((50 - filled)) | tr ' ' '-'
        printf "] %d%% (%d/%ds)" "$percent" "$i" "$total_seconds"
        
        sleep 1
    done
    
    printf "\nComplete!\n"
}

# Usage
echo "Triggering HCP report run on remote nodes..."
hcp --run-on-remote all > /dev/null 2>&1 &
wait_with_progress 60 "Giving devices time to generate HCP"
echo "Continue running script..."

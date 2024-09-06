#!/bin/bash

# Name of the tmux session
SESSION_NAME="dev"


# Check if the tmux session exists
if tmux has-session -t $SESSION_NAME 2>/dev/null; then
    # Kill the existing tmux session
    tmux kill-session -t $SESSION_NAME

    # Wait until the session is fully terminated
    while tmux has-session -t $SESSION_NAME 2>/dev/null; do
        sleep 0.2  # Check every half second to see if the session is still alive
    done
fi

# Create a new session and run "bun run dev"
tmux new-session -d -s $SESSION_NAME "bun run dev"

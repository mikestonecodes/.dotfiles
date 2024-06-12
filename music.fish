#!/usr/bin/fish

# Define the host to ping (e.g., google.com)
set HOST "google.com"

# Ping the host until it gets a response
while not ping -c 1 -W 1 $HOST > /dev/null 2>&1
    sleep 1
end

ncspot




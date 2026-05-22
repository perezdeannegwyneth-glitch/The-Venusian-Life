#!/bin/bash
# Personal Planner Launcher
# Double-click this file to open your planner

# Get the folder this script lives in
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Find a free port starting at 8765
PORT=8765
while lsof -i:$PORT &>/dev/null 2>&1; do
  PORT=$((PORT + 1))
done

echo "Starting Personal Planner on port $PORT..."

# Start Python server in the background
cd "$DIR"
python3 -m http.server $PORT &
SERVER_PID=$!

# Give it a moment to start
sleep 0.8

# Open in Chrome (preferred for PWA install), fallback to default browser
if open -a "Google Chrome" "http://localhost:$PORT/Personal_Planner.html" 2>/dev/null; then
  echo "Opened in Chrome"
elif open -a "Microsoft Edge" "http://localhost:$PORT/Personal_Planner.html" 2>/dev/null; then
  echo "Opened in Edge"
else
  open "http://localhost:$PORT/Personal_Planner.html"
  echo "Opened in default browser"
fi

# Keep server running until the terminal window is closed
echo "Server running (PID $SERVER_PID). Close this window to stop."
wait $SERVER_PID

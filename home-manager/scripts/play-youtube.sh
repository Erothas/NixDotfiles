#!/bin/sh

# Get the URL entered by the user
url=$(echo "$1" | sed 's/^.*\(https\?:\/\/.*\)$/\1/g')

# Play the video using MPV
mpv --yt-dlp-format="bestvideo[height<=2160]+bestaudio/best[height<=2160]/bestvideo+bestaudio/best" "$url"

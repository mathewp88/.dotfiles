#!/usr/bin/env bash

FileLoc="$HOME/.config/lock"
forcastFile="$FileLoc/forcast.json"

city=$(jq -r '.name' $forcastFile)

if [[ $city == "" ]]; then
    echo "No city found. Check config."
fi

country=$(jq -r '.sys.country' $forcastFile)
forcast=$(jq -r '.weather.[].description' $forcastFile)
forcast=$(echo "$forcast" | sed -e "s/\b\(.\)/\u\1/g")
temp=$(jq -r '.main.temp' $forcastFile)
temp=$(printf %.f $temp)

echo "$city, $country - $forcast, $temp°C"

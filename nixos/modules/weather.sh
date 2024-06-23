#!/usr/bin/env bash

apiKey=""
defaultLocation=""
unit="metric"
UseIcons="True"
FileLoc="$HOME/.config/lock"

ConfigFile="$FileLoc/weather.rc"

forcastFile="$FileLoc/forcast.json"

if [ "$1" == "-r" ];then
    shift
    ConfigFile="$1"
    shift
fi

if [ -f "$ConfigFile" ];then
    readarray -t line < "$ConfigFile"
    apiKey=${line[0]}
    defaultLocation=${line[1]}
    degreeCharacter=${line[2]}
    UseIcons=${line[3]}
fi

curl "https://api.openweathermap.org/data/2.5/weather?q=$defaultLocation&units=$unit&appid=$apiKey" -o $forcastFile


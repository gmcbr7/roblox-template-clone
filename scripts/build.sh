#!/bin/sh

set -u
set -x

rm -r dist \
& rojo sourcemap -o sourcemap.json \
& darklua process src dist


if [ ! -d "Packages" ]; then
    sh scripts/intall-packages.sh
fi

(
while true; do 
    sleep 2
    ROBLOX_DEV=false darklua process --config .darklua.json src/ dist/

done
) & 

rojo serve build.project.json \
    & rojo sourcemap -o sourcemap.json \
    & rojo sourcemap default.project.json -o sourcemap.json --watch \
    & blink src/Network/Network.blink --watch \
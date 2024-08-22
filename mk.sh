#!/bin/sh

mkdir -p public
rm -r public
mkdir public
zig build run -- content/ public/

#python3 -m http.server -d public/

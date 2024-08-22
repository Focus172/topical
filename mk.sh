#!/bin/sh

usage() {
    echo "mk.sh [(b)uild|(s)erve|(d)eploy]"
    exit 1
}

case $1 in
    "build" | "b")
        mkdir -p public
        rm -r public/*
        zig build run -- content/ public/
        ;;
    "serve" | "s")
        python3 -m http.server -d public/
        ;;
    "deploy" | "d")
        rsync -r public/ root@gingerfocus.dev:/var/www/scurvyless
        ;;
    *)
        usage
        ;;
esac





#!/bin/sh

name="$0"

usage() {
    echo "usage: $name build|clean|deploy|serve"
    exit 1
}

case "$1" in
    "clean" | "c")
        rm -r public
        ;;
    "build" | "b")
        zig build -p public
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


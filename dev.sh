#!/usr/bin/env bash

COMPOSE="docker-compose"

# If we pass any arguments...
if [ $# -gt 0 ]; then

    # If "jekyll" is used, pass-thru to "jekyll"
    # inside a new container
    if [ "$1" == "jekyll" ]; then
        shift 1
        $COMPOSE run --rm \
            -w /srv/jekyll \
            jekyll \
            jekyll "$@"

    # If "node" is used, pass-thru to "node"
    # inside a new container
    elif [ "$1" == "node" ]; then
        shift 1
        $COMPOSE run --rm \
            -w /custom \
            node \
            node "$@"

    # If "npm" is used, run npm
    # from our node container
    elif [ "$1" == "npm" ]; then
        shift 1
        $COMPOSE run --rm \
            -w /custom \
            node \
            npm "$@"

    # Else, pass-thru args to docker-compose
    else
        $COMPOSE "$@"
    fi

else
    $COMPOSE ps
fi
#!/usr/bin/env bash

function new() {
    mkdir $1; cd $1; git init
}

function hs() {
    history | grep $1
}

function load() {
    source ~/.bashrc
}

function pg_run() {
    if hash docker 2>/dev/null; then
        docker run --name pg-container -e POSTGRES_PASSWORD=root -p 5432:5432 -d postgres
    else
        echo 'Docker is not installed or missing from PATH.'
    fi
}

function redis_run() {
    if hash docker 2>/dev/null; then
        docker run --name redis-container -p 6379:6379 -d redis
    else
        echo 'Docker is not installed or missing from PATH.'
    fi
}

function rabbit_run() {
    if hash docker 2>/dev/null; then
        docker run --name rabbit-container -d rabbitmq
    else
        echo 'Docker is not installed or missing from PATH.'
    fi
}

function mongo_run() {
    if hash docker 2>/dev/null; then
	docker run --name some-mongo -d -p 27017:27017 mongo
    else
        echo 'Docker is not installed or missing from PATH.'
    fi
}

function cassandra_daemon() {
    if hash docker 2>/dev/null; then
	docker run --name some-cassandra --network cdb -d cassandra
    else
        echo 'Docker is not installed or missing from PATH.'
    fi
}

function cassandra_run() {
    if hash docker 2>/dev/null; then
	docker run -it --network cdb --rm cassandra cqlsh some-cassandra
    else
        echo 'Docker is not installed or missing from PATH.'
    fi
}

function vim_update() {
    if [ -f ~/.config/nvim/sync.sh ]; then
        . ~/.config/nvim/sync.sh
    else
        echo "Update script not found."
    fi
}

function repl() {
    local port="$(grep :api ~/.config/conjure/.conjure.edn | awk '{print substr($3, 1, length($3)-1)}')"
    clojure -J-Dclojure.server.jvm="{:port ${port} :accept clojure.core.server/io-prepl}"
}

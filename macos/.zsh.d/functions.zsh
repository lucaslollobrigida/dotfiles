#!/usr/bin/env bash
# shellcheck disable=SC1090

has_docker() {
    if !hash docker 2>/dev/null; then
        echo 'Docker is not installed or missing from PATH.'
        return 1
    fi
    return 0
}

hs() {
    if [[ -n "$1" ]]; then
        history \
            | grep -v -e "hs" -e "history" \
            | awk '{$1=""}1' \
            | sort \
            | uniq -c \
            | sort -nr \
            | awk '{$1=""}1' \
            | grep "$1" -m 10
    else
        history \
            | grep -v -e "hs" -e "history" \
            | awk '{$1=""}1' \
            | sort \
            | uniq -c \
            | sort -nr \
            | awk '{$1=""}1' \
            | head -n 10
    fi
}

pg_run() {
    has_docker && \
        docker run --name pg-container -e POSTGRES_PASSWORD=postgres -e POSTGRES_DB="$1" -p 5432:5432 -d postgres
}

redis_run() {
    has_docker && \
        docker run --name redis-container -p 6379:6379 -d redis
}

rabbit_run() {
    has_docker && \
        docker run -d --name rabbitmq --hostname rabbitmq \
        -p 5672:5672 \
        -p 8080:15672 \
        rabbitmq:3-management
}

mongo_run() {
    has_docker && \
        docker run --name some-mongo -d -p 27017:27017 mongo
}

cassandra_daemon() {
    has_docker && \
        docker run --name some-cassandra --network cdb -d cassandra
}

cassandra_run() {
    has_docker && \
        docker run -it --network cdb --rm cassandra cqlsh some-cassandra
}

vim_update() {
    if [ -f "$XDG_CONFIG_HOME/nvim/sync.sh" ]; then
        source "$XDG_CONFIG_HOME/nvim/sync.sh"
    else
        echo "Update script not found."
    fi
}

repl() {
    local port
    port=$(grep :api "$XDG_CONFIG_HOME/conjure/.conjure.edn" | awk '{print substr($3, 1, length($3)-1)}')
    clojure -J-Dclojure.server.jvm="{:port ${port} :accept clojure.core.server/io-prepl}"
}

cljfmt() {
    local version="0.6.4"
    clojure -Sdeps "{:deps {lein-cljfmt {:mvn/version \"$version\"}}}" \
    -m cljfmt.main fix "$@" \
    --indents .cljfmt-indents.edn
}

nsorg() {
    local version="0.3.1"
    clojure -Sdeps "{:deps {nsorg-cli {:mvn/version \"$version\"}}}" \
    -m nsorg.cli "$@" \
    --replace
}

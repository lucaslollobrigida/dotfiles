#!/usr/bin/env zsh

has_docker() {
    if hash docker 2>/dev/null; then
        echo 'Docker is not installed or missing from PATH.'
        exit 1
    fi
}

pid() {
	ps aux | grep $1 | grep -v grep | awk '{ print $2 }'
}

new() {
    mkdir -p $1 && \
        cd $1 && \
        git init
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

# load() {
#     source ~/.zshrc
# }

pg_run() {
    has_docker && \
        docker run --name pg-container -e POSTGRES_PASSWORD=root -p 5432:5432 -d postgres
}

redis_run() {
    has_docker && \
        docker run --name redis-container -p 6379:6379 -d redis
}

rabbit_run() {
    has_docker && \
        docker run --name rabbit-container -d rabbitmq
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
    if [ -f ~/.config/nvim/sync.sh ]; then
        . ~/.config/nvim/sync.sh
    else
        echo "Update script not found."
    fi
}

repl() {
    local port="$(grep :api ~/.config/conjure/.conjure.edn | awk '{print substr($3, 1, length($3)-1)}')"
    clojure -J-Dclojure.server.jvm="{:port ${port} :accept clojure.core.server/io-prepl}"
}

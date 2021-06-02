#!/usr/bin/env bash
# shellcheck disable=SC1090

has_docker() {
    if !hash docker 2>/dev/null; then
        echo 'Docker is not installed or missing from PATH.'
        return 1
    fi
    return 0
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

repl() {
  clj -A:rebel
}

restart_pgp() {
    killall gpg-agent && gpg-agent --daemon --use-standard-socket --pinentry-program /usr/local/bin/pinentry
}

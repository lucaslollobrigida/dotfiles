#!/usr/bin/env bash
# shellcheck disable=SC1090

has_docker() {
    if hash docker 2>/dev/null; then
        echo 'Docker is not installed or missing from PATH.'
        exit 1
    fi
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

so() {
    source "$HOME/.zshrc"
}

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

function mkjava() {
  if [[ -z "$1" || -z "$2" ]]; then
    echo "Specify the groupId and artifactId"
    echo "Example:"
    echo "$ mkjava com.lorem my-project"
    return 1
  fi

  ARCH=${3:-maven-archetype-quickstart}

  mvn archetype:generate \
    -DgroupId="$1" \
    -DartifactId="$2" \
    -DarchetypeArtifactId="$ARCH" \
    -DarchetypeVersion=1.4 \
    -DinteractiveMode=false

  cd "$2" || exit

  cat <<-EOF > .gitignore
  target/
  *.class
  *.jar
  *.war
EOF

  mkdir -p src/main/resources

  cat <<-EOF > src/main/resources/logback.xml
  <?xml version="1.0" encoding="UTF-8"?>
  <configuration>
      <appender name="FILE" class="ch.qos.logback.core.FileAppender">
          <file>application.log</file>
          <append>true</append>
          <encoder>
              <pattern>%d{HH:mm:ss.SSS} [%thread] %-5level  %logger{36} - %msg%n</pattern>
          </encoder>
      </appender>

      <appender name="STDOUT" class="ch.qos.logback.core.ConsoleAppender">
        <encoder>
            <pattern>%d{HH:mm:ss.SSS} [%thread] %-5level %logger{36} - %msg%n</pattern>
        </encoder>
      </appender>

      <logger name="$1" level="INFO">
          <appender-ref ref="STDOUT" />
          <appender-ref ref="FILE" />
      </logger>

      <logger name="$1.tests" level="WARN">
          <appender-ref ref="STDOUT" />
          <appender-ref ref="FILE" />
      </logger>

      <root level="DEBUG">
          <appender-ref ref="STDOUT" />
      </root>
  </configuration>
EOF

  git init
  git add .

  BOILERPLATE=$(cat <<-EOF
    <properties>
        <maven.compiler.release>11</maven.compiler.release>
    </properties>
EOF
  )

  echo
  echo "Add the following lines to pom.xml:"
  echo
  echo "$BOILERPLATE"
  echo
}

FROM ubuntu:bionic

RUN mkdir -p /usr/src/install
WORKDIR /usr/src/install

COPY . .

RUN ./setup.sh "Lucas Lollobrigida" "lucaslollobrigida@gmail" --zsh
# CMD ["./setup.sh", "Lucas Lollobrigida", "lucaslollobrigida@gmail.com", "--zsh"]

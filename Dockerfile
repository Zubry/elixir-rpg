FROM elixir:latest
RUN apt-get update -qq && apt-get install -y telnet
ADD . /mmo
WORKDIR /mmo/mmo
EXPOSE 4500
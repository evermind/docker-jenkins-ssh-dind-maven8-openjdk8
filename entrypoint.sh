#!/bin/sh

set -e

dockerd --mtu 1378 &

docker_running=0
counter=10
while [ $counter -ge 1 ]; do
  echo "Waiting for dockerd ($counter / 10)"
  if $( docker info > /dev/null 2>&1 ); then
    docker_running=1
    break
  fi
  counter=$(( counter-1 ))
  sleep 1
done
if [ $docker_running -ne 1 ]; then
  echo "Timeout while waiting for dockerd. See logs above for errors!"
  exit 1
fi

/usr/local/bin/setup-sshd "${@}"

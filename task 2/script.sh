#!/bin/bash
set -euo pipefail
port=8080
healthcheck_flag=0
stop_container() {
  if [[ "$healthcheck_flag" -eq 0 ]]
  then
    echo "Stopping container..."
    docker stop go-app
    echo "Stopped container."
  fi
}
trap stop_container EXIT

while [[ $# -gt 0 ]]; do
    case "$1" in
        --port)
            if [[ $# -lt 2 ]]; then
                echo "Error: --port option requires an argument."
                exit 2
            fi
            port=$2
            shift 2
            ;;
        --healthcheck)
            healthcheck_flag=1
            shift
            ;;
    esac
done

if [[ "$healthcheck_flag" -eq 1 ]]
then
  set +e
  is_running=$(docker inspect -f {{.State.Status}} go-app 2>/dev/null)
  set -e
  if [[ "$is_running" == "running" ]]
  then
    echo "Container is running."
  else
    echo "Container is not running."
  fi
else
  echo "Building docker image..."
  docker build -t my-go-app .
  echo "Built docker image."
  echo "Starting container..."
  docker run -d -p "$port":"$port" -e BIND_ADDRESS=":$port" --name go-app my-go-app
  echo "Started container."
fi

#!/usr/bin/env bash
set -euo pipefail

# Optional directory to mount (default: compose project root, i.e. ".")
MOUNT_DIR="${1:-}"

# Run from the directory that contains docker-compose.yml so volume mounts
# and build contexts resolve correctly. Resolve symlinks on $0 first so this
# works whether the script is invoked by absolute path, relative path
# (`./run_pi_web.sh`), or through a symlink from another directory.
SELF="$(readlink -f "$0")"
cd "$(dirname "$SELF")/.." || exit 1

# `docker compose` reads UID/GID from the environment for ${...}
# substitution in docker-compose.yaml. bash sets $UID automatically but
# does not export it, and $GID isn't set at all, so export both explicitly.
# Bind-mount sources must exist beforehand: if Docker has to create them
# itself, it does so before any user-namespace remapping applies, which
# can leave them oddly owned. Creating them here guarantees they're
# owned by you.
mkdir -p ~/.pi/agent ~/.agents

# Rootless Docker doesn't expose /var/run/docker.sock; the real socket
# lives under the user's runtime dir. Testcontainers (run by mvn/gradle
# inside this container) needs it to spin up its own sibling containers.
export DOCKER_SOCK="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/docker.sock"
if [ ! -S "$DOCKER_SOCK" ]; then
  echo "Warning: rootless docker socket not found at $DOCKER_SOCK — testcontainers won't work" >&2
fi

# Rootless Docker also breaks Testcontainers' two assumptions about where
# things live; both are fixed by telling Testcontainers the host-side truth:
#
# 1. TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE: when Testcontainers starts Ryuk it
#    bind-mounts the Docker socket path it sees (DOCKER_HOST=unix:///var/run/...)
#    into the container. The daemon resolves bind sources on the HOST, where
#    rootless Docker has no socket at /var/run/docker.sock (it's under the
#    user's runtime dir), so Ryuk gets a dead directory and exits. Pointing
#    Testcontainers at the real host socket path fixes it.
#
# 2. TESTCONTAINERS_HOST_OVERRIDE: rootless Docker publishes container ports on
#    the host via rootlesskit (bound to the host's interfaces), not on the
#    bridge gateway. Testcontainers normally connects to the sibling container
#    at the bridge gateway (172.17.0.1), which nothing listens on here, so all
#    JDBC/Ryuk connections fail. The one place the published port IS reachable
#    from inside the dev container is the host's own IP, so use that.
export TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE="$DOCKER_SOCK"
HOST_IP="$(ip -4 route get 1.1.1.1 2>/dev/null | sed -n 's/.*src \([0-9.]*\).*/\1/p' || true)"
if [ -z "$HOST_IP" ]; then
  HOST_IP="$(hostname -I 2>/dev/null | awk '{print $1}')"
fi
export TESTCONTAINERS_HOST_OVERRIDE="$HOST_IP"
if [ -z "$HOST_IP" ]; then
  echo "Warning: could not determine host IP — testcontainers won't be able to reach containers" >&2
fi

# (Re)build the pi image.
docker compose build pi

# Start the searxng dependency in the background and wait until it's healthy.
docker compose up -d --wait searxng

# Launch pi with an attached interactive TTY (the compose equivalent of
# `docker run -it`). `exec` hands the terminal over to pi so Ctrl-D / exit
# stop the container and return you to your shell.
if [ -n "$MOUNT_DIR" ]; then
  MOUNT_DIR="$(realpath "$MOUNT_DIR")"
  if [ ! -d "$MOUNT_DIR" ]; then
    echo "Error: '$MOUNT_DIR' is not a directory" >&2
    exit 1
  fi
  exec docker compose run --rm --name pi-sandbox \
    -e TESTCONTAINERS_HOST_OVERRIDE -e TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE \
    -v "$MOUNT_DIR:/workspace" pi
else
  exec docker compose run --rm --name pi-sandbox \
    -e TESTCONTAINERS_HOST_OVERRIDE -e TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE \
    pi
fi

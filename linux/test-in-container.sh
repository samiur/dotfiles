#!/usr/bin/env bash
# ABOUTME: End-to-end test: runs bootstrap.sh in a fresh Ubuntu container, then doctor.sh.
# ABOUTME: Also fails if the bootstrap leaves the dotfiles checkout dirty.

set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
IMAGE=dotfiles-bootstrap-test
UBUNTU=${UBUNTU:-ubuntu:26.04}

work="$(mktemp -d)"
trap 'rm -rf "$work"' EXIT

# Snapshot the checkout, including uncommitted changes, as a baseline commit.
rsync -a --exclude .git "$DOTFILES/" "$work/dotfiles/"
git -C "$work/dotfiles" init -q
git -C "$work/dotfiles" add -A
git -C "$work/dotfiles" -c user.name=test -c user.email=test@example.com commit -qm baseline

docker build -q -t "$IMAGE" - >/dev/null <<EOF
FROM $UBUNTU
RUN apt-get update -q && apt-get install -yq sudo git curl ca-certificates openssh-client rsync locales \
 && locale-gen en_US.UTF-8 \
 && (userdel -r ubuntu 2>/dev/null || true) \
 && useradd -m -u $(id -u) -s /bin/bash $USER \
 && echo "$USER ALL=(ALL) NOPASSWD:ALL" >/etc/sudoers.d/$USER \
 && install -d -o $USER -g $USER /home/$USER/Dev /home/$USER/Dev/repos
USER $USER
WORKDIR /home/$USER
ENV USER=$USER LANG=en_US.UTF-8 TERM=xterm-256color
EOF

# The host's SSH key is mounted read-only so the private samiur/claude-skills marketplace can clone.
docker run --rm \
  -v "$work/dotfiles:/home/$USER/Dev/repos/dotfiles" \
  -v "$HOME/.ssh:/tmp/host-ssh:ro" \
  "$IMAGE" bash -c '
    set -euo pipefail
    mkdir -p ~/.ssh && cp /tmp/host-ssh/id_ed25519* ~/.ssh/ && chmod 600 ~/.ssh/id_ed25519
    ssh-keyscan -q github.com >>~/.ssh/known_hosts 2>/dev/null
    ~/Dev/repos/dotfiles/linux/bootstrap.sh all
    echo "==> second run, to prove the steps are re-runnable"
    ~/Dev/repos/dotfiles/linux/bootstrap.sh user
    ~/Dev/repos/dotfiles/linux/doctor.sh
  ' || status=$?

dirty="$(git -C "$work/dotfiles" status --porcelain)"
if [[ -n "$dirty" ]]; then
  echo "bootstrap left the dotfiles checkout dirty:"
  echo "$dirty" | head -20
  status=1
fi
if (( ${status:-0} != 0 )); then
  echo "container test failed"
  exit 1
fi
echo "container test passed"

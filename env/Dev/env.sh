# Sourced from ~/.profile by both bash and zsh, so keep this POSIX-compatible.
# Every tool below is optional: guard on its presence so the same file works on
# macOS (Homebrew) and Linux without startup noise.

if [ -f ~/Dev/.env ]; then
  set -a
  . ~/Dev/.env
  set +a
fi

if command -v pyenv > /dev/null 2>&1; then
  eval "$(pyenv init --path)"
  eval "$(pyenv virtualenv-init -)"
fi

if command -v mise > /dev/null 2>&1; then
  if [ -n "$ZSH_VERSION" ]; then
    eval "$(mise activate zsh)"
  elif [ -n "$BASH_VERSION" ]; then
    eval "$(mise activate bash)"
  fi
fi

if command -v jenv > /dev/null 2>&1; then eval "$(jenv init -)"; fi

alias dc=docker-compose

alias kc=kubectl

export GOPATH="${HOME}/go"
export PATH="$PATH:${GOPATH}/bin"

if command -v brew > /dev/null 2>&1; then
  export GOROOT="$(brew --prefix golang)/libexec"
  export PATH="$PATH:${GOROOT}/bin"
  export PATH="$(brew --prefix gnu-tar)/libexec/gnubin:$PATH"

  export LDFLAGS="-L$(brew --prefix openssl)/lib"
  export CPPFLAGS="-I$(brew --prefix openssl)/include"
fi

[ -d "$HOME/.rbenv/shims" ] && export PATH="$PATH:$HOME/.rbenv/shims"

# Raising the hard limit fails for non-root on Linux; only lift the soft limit
# up to whatever the hard limit allows.
ulimit -n 65536 65536 2> /dev/null || ulimit -n "$(ulimit -Hn)" 2> /dev/null
ulimit -f unlimited 2> /dev/null

GPG_TTY=$(tty)
export GPG_TTY

# Other env vars
export CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1

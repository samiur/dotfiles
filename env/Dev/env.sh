set -a
source ~/Dev/canopy/.env
set +a

eval "$(pyenv init --path)"
eval "$(pyenv virtualenv-init -)"

if which jenv > /dev/null; then eval "$(jenv init -)"; fi

alias dc=docker-compose
alias dc-python-dev="docker-compose -f docker-compose.yml -f packages/canopy-python/docker-compose.override.yml"

alias kc=kubectl
alias kc-prod="kubectl --context=kube.usejournal.com"
alias kc-staging="kubectl --context=kube.staging.canopyiq.com"

alias mypy-daemon="dmypy run --"

export GOPATH="${HOME}/go"
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"
export PATH="$(brew --prefix)/opt/gnu-tar/libexec/gnubin:$PATH"

export LDFLAGS="-L/usr/local/opt/openssl/lib"
export CPPFLAGS="-I/usr/local/opt/openssl/include"

ulimit -n 65536 65536
ulimit -f unlimited

GPG_TTY=$(tty)
export GPG_TTY

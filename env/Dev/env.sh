set -a
source ~/Dev/.env
set +a

eval "$(pyenv init --path)"
eval "$(pyenv virtualenv-init -)"

# Added by `rbenv init` on Thu Nov 21 17:35:44 PST 2024
eval "$(rbenv init - --no-rehash zsh)"

if which jenv > /dev/null; then eval "$(jenv init -)"; fi

alias dc=docker-compose

alias kc=kubectl

export GOPATH="${HOME}/go"
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"
export PATH="$(brew --prefix gnu-tar)/libexec/gnubin:$PATH"
export PATH="$PATH:$HOME/.rbenv/shims"

export LDFLAGS="-L$(brew --prefix openssl)/lib"
export CPPFLAGS="-I$(brew --prefix openssl)/include"

ulimit -n 65536 65536
ulimit -f unlimited

GPG_TTY=$(tty)
export GPG_TTY

export MYPYPATH="${HOME}/Dev/python/mypy"

# bash: keep the interactive config and user bin dirs the stock Ubuntu
# .profile would have provided.
if [ -n "$BASH_VERSION" ] && [ -f "$HOME/.bashrc" ]; then
  . "$HOME/.bashrc"
fi
[ -d "$HOME/bin" ] && PATH="$HOME/bin:$PATH"
[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"

[ -f ~/Dev/env.sh ] && . ~/Dev/env.sh

# uv
[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"

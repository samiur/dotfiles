#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
emulate sh -c 'source /Users/samiur/.betterup_profile/init.sh'

# Load direnv
eval "$(direnv hook zsh)"

. "$HOME/.local/bin/env"

# Added by Antigravity
export PATH="/Users/samiur/.antigravity/antigravity/bin:$PATH"

# OpenClaw Completion
source <(openclaw completion --shell zsh)

# bun completions
[ -s "/Users/samiur/.bun/_bun" ] && source "/Users/samiur/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

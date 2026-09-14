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

# Added by git-ai installer on Mon Jun 15 11:33:15 PDT 2026
export PATH="/Users/samiur/.git-ai/bin:$PATH"

# Prefer the native Claude Code build (~/.local/bin) over any npm/brew copies
export PATH="$HOME/.local/bin:$PATH"

# opencode
export PATH=/Users/samiur/.opencode/bin:$PATH

# Homebrew has no post-upgrade hook, and every emacs-plus upgrade orphans the
# /Applications/Emacs.app Finder alias, so repair it whenever brew touches packages.
brew() {
  command brew "$@"
  local ret=$?
  case "${1:-}" in
    upgrade|install|reinstall) fix-emacs-alias || true ;;
  esac
  return $ret
}

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
if [[ -f "$HOME/.betterup_profile/init.sh" ]]; then
  emulate sh -c "source $HOME/.betterup_profile/init.sh"
fi

# Load direnv
if (( $+commands[direnv] )); then
  eval "$(direnv hook zsh)"
fi

# uv
[[ -f "$HOME/.local/bin/env" ]] && . "$HOME/.local/bin/env"

# Added by Antigravity
[[ -d "$HOME/.antigravity/antigravity/bin" ]] && export PATH="$HOME/.antigravity/antigravity/bin:$PATH"

# OpenClaw Completion
if (( $+commands[openclaw] )); then
  source <(openclaw completion --shell zsh)
fi

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
if [[ -d "$HOME/.bun" ]]; then
  export BUN_INSTALL="$HOME/.bun"
  export PATH="$BUN_INSTALL/bin:$PATH"
fi

# Added by git-ai installer on Mon Jun 15 11:33:15 PDT 2026
[[ -d "$HOME/.git-ai/bin" ]] && export PATH="$HOME/.git-ai/bin:$PATH"

# Prefer the native Claude Code build (~/.local/bin) over any npm/brew copies
export PATH="$HOME/.local/bin:$PATH"

# opencode
[[ -d "$HOME/.opencode/bin" ]] && export PATH="$HOME/.opencode/bin:$PATH"

# Homebrew has no post-upgrade hook, and every emacs-plus upgrade orphans the
# /Applications/Emacs.app Finder alias, so repair it whenever brew touches packages.
if [[ "$OSTYPE" == darwin* ]]; then
  brew() {
    command brew "$@"
    local ret=$?
    case "${1:-}" in
      upgrade|install|reinstall) fix-emacs-alias || true ;;
    esac
    return $ret
  }
fi

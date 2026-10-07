#!/usr/bin/env bash
# ABOUTME: Sets up an Ubuntu machine with the same shell, editor, and Claude Code setup as the Mac.
# ABOUTME: Run "system" once with sudo access, then "user"; every step is safe to re-run.

set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
STOW_PACKAGES=(claude env spacemacs tmux zsh)
GSD_VERSION=1.30.0
APT_PACKAGES=(zsh git stow tmux emacs-nox direnv gh jq curl unzip build-essential clangd)

export PATH="$HOME/.local/bin:$HOME/.local/share/mise/shims:$HOME/.bun/bin:$PATH"

log() { printf '\n==> %s\n' "$*"; }

system_setup() {
  log "apt packages"
  sudo apt-get update -q
  sudo apt-get install -yq "${APT_PACKAGES[@]}"
  if ! command -v docker >/dev/null; then
    sudo apt-get install -yq docker.io
  fi

  log "login shell"
  if [[ "$(getent passwd "$USER" | cut -d: -f7)" != */zsh ]]; then
    sudo chsh -s "$(command -v zsh)" "$USER"
  fi

  if command -v npx >/dev/null; then
    playwright_deps
  fi
}

playwright_deps() {
  log "playwright browser dependencies"
  sudo env "PATH=$PATH" npx -y playwright install-deps chromium
}

# Move aside plain files that would block stow, such as the ~/.profile Ubuntu ships.
# A file reached through an already-stowed directory link is this repo's own file, so it stays put.
clear_stow_conflicts() {
  local pkg="$1" src target repo
  repo="$(readlink -f "$DOTFILES")"
  while IFS= read -r src; do
    target="$HOME/${src#"$DOTFILES/$pkg/"}"
    [[ "$(readlink -f "$target")" == "$repo"/* ]] && continue
    if [[ -e "$target" && ! -L "$target" && ! -d "$target" ]]; then
      mv "$target" "$target.pre-dotfiles"
    fi
  done < <(find "$DOTFILES/$pkg" -mindepth 1 \( -type f -o -type l \))
}

install_shell() {
  log "prezto"
  if [[ ! -d "$HOME/.zprezto" ]]; then
    git clone -q --recursive https://github.com/sorin-ionescu/prezto.git "$HOME/.zprezto"
  fi

  log "oh-my-tmux"
  if [[ ! -d "$HOME/.tmux" ]]; then
    git clone -q https://github.com/gpakosz/.tmux.git "$HOME/.tmux"
  fi
  ln -sfn "$HOME/.tmux/.tmux.conf" "$HOME/.tmux.conf"

  log "spacemacs"
  # A folded stow link would put the spacemacs checkout inside this repo.
  if [[ -L "$HOME/.emacs.d" ]]; then
    stow -d "$DOTFILES" -t "$HOME" -D spacemacs
  fi
  if [[ ! -d "$HOME/.emacs.d" ]]; then
    git clone -q --branch develop https://github.com/syl20bnr/spacemacs "$HOME/.emacs.d"
  fi

  log "stow: ${STOW_PACKAGES[*]}"
  # Without these, stow folds each directory into one link and everything later written there lands in this repo.
  mkdir -p "$HOME/.claude" "$HOME/Dev"
  local pkg
  for pkg in "${STOW_PACKAGES[@]}"; do
    clear_stow_conflicts "$pkg"
    # stow can report a failed symlink and still exit 0, so fail on any output.
    local out
    out="$(stow -d "$DOTFILES" -t "$HOME" "$pkg" 2>&1)"
    if [[ -n "$out" ]]; then
      echo "$out" >&2
      return 1
    fi
  done
}

install_toolchain() {
  log "uv"
  if ! command -v uv >/dev/null; then
    curl -LsSf https://astral.sh/uv/install.sh | env UV_NO_MODIFY_PATH=1 sh
  fi

  log "mise"
  if ! command -v mise >/dev/null; then
    curl -fsSL https://mise.run | MISE_INSTALL_PATH="$HOME/.local/bin/mise" sh
  fi

  log "node"
  if ! command -v node >/dev/null; then
    mise use -g node@22
    mise reshim
  fi

  log "bun"
  # The bun installer edits ~/.zshrc, which is a symlink into this repo, so unpack the release directly.
  if ! command -v bun >/dev/null; then
    local arch tmp
    case "$(uname -m)" in
      x86_64) arch=x64 ;;
      aarch64) arch=aarch64 ;;
      *) echo "unsupported arch $(uname -m)" >&2; return 1 ;;
    esac
    tmp="$(mktemp -d)"
    curl -fsSL -o "$tmp/bun.zip" "https://github.com/oven-sh/bun/releases/latest/download/bun-linux-$arch.zip"
    unzip -q "$tmp/bun.zip" -d "$tmp"
    mkdir -p "$HOME/.bun/bin"
    mv "$tmp/bun-linux-$arch/bun" "$HOME/.bun/bin/bun"
    rm -rf "$tmp"
  fi
  ln -sfn bun "$HOME/.bun/bin/bunx"

  log "typescript language server"
  if ! command -v typescript-language-server >/dev/null; then
    npm install -g typescript typescript-language-server
    mise reshim
  fi
  # A node that mise does not manage keeps npm's global bin dir off PATH, so link the binaries in.
  if ! command -v typescript-language-server >/dev/null; then
    local npm_bin
    npm_bin="$(npm prefix -g)/bin"
    ln -sfn "$npm_bin/typescript-language-server" "$HOME/.local/bin/typescript-language-server"
    ln -sfn "$npm_bin/tsc" "$HOME/.local/bin/tsc"
  fi
}

install_claude() {
  log "claude code"
  if ! command -v claude >/dev/null; then
    curl -fsSL https://claude.ai/install.sh | bash
  fi

  log "claude settings"
  local settings="$HOME/.claude/settings.json"
  mkdir -p "$HOME/.claude"
  [[ -s "$settings" ]] || echo '{}' >"$settings"
  jq -s '.[0] * .[1]' "$settings" "$DOTFILES/linux/claude-settings.json" >"$settings.tmp"
  mv "$settings.tmp" "$settings"

  log "claude plugins"
  local plugin source
  while read -r plugin source; do
    [[ -z "$plugin" || "$plugin" == \#* ]] && continue
    if ! claude plugin marketplace list 2>/dev/null | grep -q "${plugin#*@}"; then
      claude plugin marketplace add "$source"
    fi
    claude plugin install --scope user "$plugin"
  done <"$DOTFILES/linux/claude-plugins.txt"

  log "get-shit-done $GSD_VERSION"
  if [[ "$(cat "$HOME/.claude/get-shit-done/VERSION" 2>/dev/null)" != "$GSD_VERSION" ]]; then
    npx -y "get-shit-done-cc@$GSD_VERSION" --claude --global </dev/null
  fi

  log "gstack"
  if [[ ! -d "$HOME/.claude/skills/gstack" ]]; then
    git clone -q https://github.com/garrytan/gstack.git "$HOME/.claude/skills/gstack"
  fi
  (cd "$HOME/.claude/skills/gstack" && ./setup -q </dev/null)

  log "humanizer"
  if [[ ! -d "$HOME/.claude/skills/humanizer" ]]; then
    git clone -q https://github.com/blader/humanizer.git "$HOME/.claude/skills/humanizer"
  fi

  log "skills.sh skills"
  npx -y skills add mattpocock/skills -g -a claude-code -y \
    -s diagnosing-bugs grill-me grill-with-docs handoff setup-matt-pocock-skills
  npx -y skills add clerk/skills -g -a claude-code -y -s '*'
  npx -y skills add vercel-labs/agent-skills -g -a claude-code -y \
    -s vercel-react-best-practices web-design-guidelines
  npx -y skills add anthropics/skills -g -a claude-code -y -s frontend-design

  log "mcp servers"
  local existing
  existing="$(claude mcp list 2>/dev/null || true)"
  grep -q '^sequential-thinking:' <<<"$existing" ||
    claude mcp add -s user sequential-thinking -- npx -y @modelcontextprotocol/server-sequential-thinking
  grep -q '^playwright:' <<<"$existing" ||
    claude mcp add -s user playwright -- npx -y @playwright/mcp --headless --browser chromium
  grep -q '^fetch:' <<<"$existing" ||
    claude mcp add -s user fetch -- npx -y @kazuph/mcp-fetch
  grep -q '^openaiDeveloperDocs:' <<<"$existing" ||
    claude mcp add -s user --transport http openaiDeveloperDocs https://developers.openai.com/mcp
  npx -y playwright install chromium
}

user_setup() {
  install_shell
  install_toolchain
  install_claude
  log "done; run linux/doctor.sh to verify"
}

case "${1:-}" in
  system) system_setup ;;
  user) user_setup ;;
  # Separate statements, not an && chain, so set -e still applies inside each step.
  all)
    system_setup
    user_setup
    playwright_deps
    ;;
  *) echo "usage: $0 system|user|all" >&2; exit 2 ;;
esac

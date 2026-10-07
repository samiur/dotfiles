#!/usr/bin/env bash
# ABOUTME: Verifies a Linux machine matches the dev setup that bootstrap.sh installs.
# ABOUTME: Prints one line per check and exits non-zero if any check fails.

set -uo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES="${DOTFILES:-$(dirname "$SCRIPT_DIR")}"
export PATH="$HOME/.local/bin:$HOME/.local/share/mise/shims:$HOME/.bun/bin:$PATH"

# Plugins and marketplaces the bootstrap installs; BetterUp's must stay off this machine.
EXPECTED_PLUGINS=$(grep -v '^#' "$SCRIPT_DIR/claude-plugins.txt" | awk 'NF {print $1}')
EXPECTED_MCP="sequential-thinking playwright fetch openaiDeveloperDocs"

failures=0
pass() { printf '  ok    %s\n' "$1"; }
fail() { printf '  FAIL  %s\n' "$1"; failures=$((failures + 1)); }
check() {
  local label="$1"; shift
  if "$@" >/dev/null 2>&1; then pass "$label"; else fail "$label"; fi
}
links_into_dotfiles() {
  [[ -L "$1" ]] && [[ "$(readlink -f "$1")" == "$(readlink -f "$DOTFILES")"/* ]]
}

echo "layout"
for d in .claude Dev; do
  check "~/$d is a real directory, not a stow link" bash -c "[[ -d ~/$d && ! -L ~/$d ]]"
done

echo "shell"
check "login shell is zsh" bash -c '[[ "$(getent passwd "$USER" | cut -d: -f7)" == */zsh ]]'
check "prezto installed" test -s "$HOME/.zprezto/init.zsh"
for f in .zshrc .zprofile .zshenv .zpreztorc .profile Dev/env.sh; do
  check "$f links into dotfiles" links_into_dotfiles "$HOME/$f"
done
zsh_stderr=$(zsh -i -c exit 2>&1 >/dev/null)
if [[ -z "$zsh_stderr" ]]; then pass "interactive zsh starts without errors"; else fail "interactive zsh starts without errors: $zsh_stderr"; fi

echo "tools (as an interactive zsh sees them)"
for cmd in git stow tmux emacs direnv gh jq mise bun bunx uv node npm npx typescript-language-server claude docker; do
  check "$cmd on PATH" zsh -i -c "command -v $cmd"
done
check "npm runs" zsh -i -c "npm --version"

echo "tmux"
check "oh-my-tmux checked out" test -f "$HOME/.tmux/.tmux.conf"
check ".tmux.conf points at oh-my-tmux" bash -c '[[ "$(readlink -f ~/.tmux.conf)" == "$(readlink -f ~/.tmux/.tmux.conf)" ]]'
check ".tmux.conf.local links into dotfiles" links_into_dotfiles "$HOME/.tmux.conf.local"

echo "emacs"
check "~/.emacs.d is a spacemacs checkout, not a symlink" bash -c '[[ ! -L ~/.emacs.d ]] && git -C ~/.emacs.d remote get-url origin | grep -q syl20bnr/spacemacs'
check ".spacemacs links into dotfiles" links_into_dotfiles "$HOME/.spacemacs"
check "private layers link into dotfiles" links_into_dotfiles "$HOME/.emacs.d/private/samiur-python"
check "dotfiles spacemacs package holds no spacemacs checkout" test ! -e "$DOTFILES/spacemacs/.emacs.d/core"

echo "claude code"
check "CLAUDE.md links into dotfiles" links_into_dotfiles "$HOME/.claude/CLAUDE.md"
check "commands link into dotfiles" links_into_dotfiles "$HOME/.claude/commands"
check "docs link into dotfiles" links_into_dotfiles "$HOME/.claude/docs"
settings="$HOME/.claude/settings.json"
check "settings: opus model" jq -e '.model == "opus"' "$settings"
check "settings: auto permission mode" jq -e '.permissions.defaultMode == "auto"' "$settings"
check "settings: agent teams enabled" jq -e '.env.CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS == "1"' "$settings"
check "settings: GSD statusline" jq -e '.statusLine.command | test("gsd-statusline")' "$settings"
check "settings: no macOS sleep hooks" jq -e '[.. | .command? // empty | select(test("sleep.sh"))] | length == 0' "$settings"
check "settings: no BetterUp plugins" jq -e '[.enabledPlugins // {} | keys[] | select(test("betterup"))] | length == 0' "$settings"
check "settings: no BetterUp marketplaces" bash -c "! claude plugin marketplace list 2>/dev/null | grep -qi betterup"
installed_plugins=$(jq -r '.plugins | keys[]' "$HOME/.claude/plugins/installed_plugins.json" 2>/dev/null)
for p in $EXPECTED_PLUGINS; do
  check "plugin $p" grep -qx "$p" <<<"$installed_plugins"
done
check "GSD installed" test -s "$HOME/.claude/get-shit-done/VERSION"
check "gstack checked out" git -C "$HOME/.claude/skills/gstack" rev-parse
check "gstack skills linked" test -e "$HOME/.claude/skills/review/SKILL.md"
check "humanizer checked out" test -f "$HOME/.claude/skills/humanizer/SKILL.md"
for s in grill-me grill-with-docs handoff setup-matt-pocock-skills diagnosing-bugs clerk-setup vercel-react-best-practices web-design-guidelines frontend-design; do
  check "skill $s" test -f "$HOME/.claude/skills/$s/SKILL.md"
done
mcp_list=$(claude mcp list 2>/dev/null)
for m in $EXPECTED_MCP; do
  check "mcp $m" grep -q "^$m:" <<<"$mcp_list"
done

echo
if (( failures > 0 )); then
  echo "$failures check(s) failed"
  exit 1
fi
echo "all checks passed"

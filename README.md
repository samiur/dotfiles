# dotfiles
Various dotfiles (emacs, zsh, etc.)

## Linux (Ubuntu)

The Mac is set up by `osx-bootstrap`. On Ubuntu, clone this repo to `~/Dev/repos/dotfiles` and run:

```sh
linux/bootstrap.sh system   # apt packages, login shell, browser deps (needs sudo)
linux/bootstrap.sh user     # prezto, oh-my-tmux, spacemacs, stow, toolchain, Claude Code
linux/doctor.sh             # verify
```

Both steps are safe to re-run. `linux/test-in-container.sh` runs the whole bootstrap in a fresh Ubuntu container and then runs the doctor.

Claude Code on Linux gets the personal and public plugins in `linux/claude-plugins.txt` and the settings in `linux/claude-settings.json`, merged into whatever `~/.claude/settings.json` already holds. The GSD and gstack installers add their own hooks and statusline. A few steps need a browser and stay manual: `claude` login, `gh auth login`, and any MCP server that uses OAuth.

# Personal zsh config for macOS

Modular zsh setup: login env in `.zprofile`, interactive shell in `.zshrc`, shared bits under `.zsh/`.

## Prerequisites

- macOS with [Homebrew](https://brew.sh) (paths assume Apple Silicon `/opt/homebrew`)
- Optional: [Rust](https://rustup.rs) (`~/.cargo/env`), [OrbStack](https://orbstack.dev), Node/npm, Git

```bash
brew install zsh-syntax-highlighting zsh-history-substring-search zoxide thefuck
```

## Install

Clone the repo, then symlink from the `zsh/` directory (set `DOTFILES` to your clone path):

```bash
DOTFILES="$HOME/path/to/zephyr-silent-harbor"

ln -sfn "$DOTFILES/zsh/.zshrc"    "$HOME/.zshrc"
ln -sfn "$DOTFILES/zsh/.zprofile" "$HOME/.zprofile"
ln -sfn "$DOTFILES/zsh/.zsh"      "$HOME/.zsh"
```

If `~/.zsh` is already a real directory, move or back it up before linking. Open a new terminal or run `exec zsh -l`.

## Machine-specific env

Copy or create `zsh/.zsh/env.local.sh` (gitignored) for per-machine exports, e.g. `XDEBUG_TRIGGER=yes`. Sourced from `env.sh` after shared defaults.

## Security

Do not commit API keys, tokens, passwords, or other secrets — use `env.local.sh` only. History, zoxide data, and session files stay in `$HOME`, not this repo.

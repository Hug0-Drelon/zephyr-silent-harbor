# Personal zsh config for macOS

Modular zsh setup: login env in `.zprofile`, interactive shell in `.zshrc`, shared bits under `.zsh/`.

## Syntax highlighting & interactive defaults

**Colors** ([zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting), tuned in `plugins.zsh`):

- **Blue** — command word on `PATH` (`arg0`); **blue + underline** for precommands (`sudo`, `command`, …) and similar cases.
- **Red (bold)** — shell syntax the highlighter treats as invalid (`unknown-token`).
- **Default / other colors** — options, quotes, paths, globs, etc. (plugin defaults).

Syntax highlighting rules:

- Checks **zsh commands** only, not app subcommands
- **Blue** — valid command word
- **Red (bold)** — invalid or unknown command / shell token

**Git branch** (`prompt.zsh`, first match wins):

- **Yellow** — unstaged or untracked changes
- **Cyan** — staged changes only
- **Magenta** — ahead, behind, or diverged vs upstream
- **Green** — clean working tree (or no upstream)

**Prompt** (`prompt.zsh`) **`$`** / **`#`** ( **`#`** when root):

- **Dim** when previous command passed
- **Red** when previous command failed (not Ctrl+C / exit 130)

**Interactive tweaks** (`interactive.zsh`): shared deduplicated history (`~/.zsh_history`, 10k lines); `autocd` and `extendedglob`; `noclobber` (`>|` to overwrite); `rm *` guard + 10s wait; `#` comments on the line; Unicode combining chars in the editor.

## Prerequisites

- macOS with [Homebrew](https://brew.sh) (paths assume Apple Silicon `/opt/homebrew`)
- Optional: [Rust](https://rustup.rs) (`~/.cargo/env`), [OrbStack](https://orbstack.dev), Node/npm, Git

```bash
brew install zsh-syntax-highlighting zsh-history-substring-search zoxide thefuck fzf
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

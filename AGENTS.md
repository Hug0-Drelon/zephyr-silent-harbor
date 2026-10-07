# Agent instructions (zephyr-silent-harbor)

Personal **zsh** dotfiles for **macOS 26+**, Apple Silicon (`/opt/homebrew`), plus optional **Ollama** modelfiles. Not a generic shell framework. User docs: [README.md](README.md).

## Layout

- `zsh/` → symlinks `~/.zshrc`, `~/.zprofile`, `~/.zsh`; root `set-up.zsh` installs them.
- `ollama/` → `modelfiles/` + `set-up.zsh` (stays in the repo, not `$HOME`).
- Edit only under `zsh/`; ignore stray `.zsh/` at repo root.

## Conventions

- `env.sh` / `tools/*.sh`: POSIX `sh`, idempotent (`SHELL_ENV_LOADED`). `*.zsh`: zsh-only; tabs per `.editorconfig`.
- Per-machine overrides: `zsh/.zsh/env.local.sh` (gitignored) — secrets, dev toggles, `OLLAMA_*`.

Commit only when asked. Use conventional commits.

## Security

Never commit API keys, tokens, passwords, private URLs, SSH keys, `.env`, or shell history. Scan diffs for leaks before commit; rotate anything that was pushed.

## Load order

Login: `.zprofile` → `env.sh`, `homebrew.sh`, optional OrbStack.

Interactive: guarded `env.sh` → `prompt.zsh` → `aliases.zsh` → `interactive.zsh` → `plugins.zsh` → `ai.zsh` (syncs `OLLAMA_*` from `env.local.sh` to launchd once per session if `ollama` exists).

## Ollama

Tracked **modelfiles** only (variant name = filename; user runs `ollama/set-up.zsh` → `ollama create`). Do not put `OLLAMA_*` or RAM/GPU defaults in tracked files. `ai.zsh` may restart `Ollama.app` or `brew services ollama` when launchd env drifts. README § Ollama for tuning (`KV_CACHE_TYPE`, `MAX_LOADED_MODELS`, etc.).

## Agent constraints

- Minimal diffs; match existing style.
- No install frameworks, ShellCheck directive churn, or unprompted `git` / `brew` / `ollama create` / `~` dotfile changes.
- After shell edits: `zsh -n zsh/.zshrc zsh/.zprofile zsh/.zsh/*.zsh`.
- Bash `~/.bashrc` / `~/.profile` are out of repo unless asked.

Target: Homebrew `/opt/homebrew`; optional Rust (`cargo.sh`), OrbStack, thefuck, zoxide, npm (`command -v` guards).

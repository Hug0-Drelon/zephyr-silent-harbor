# POSIX shared environment (safe to source from any shell entry point).
[[ -z "${SHELL_ENV_LOADED:-}" ]] && emulate sh -c ". \"$HOME/.zsh/env.sh\""

export PATH="$HOME/.local/bin:$PATH"

# Load prompt, aliases and interactive settings.
source "$HOME/.zsh/prompt.zsh"
source "$HOME/.zsh/aliases.zsh"
source "$HOME/.zsh/interactive.zsh"
source "$HOME/.zsh/plugins.zsh"
source "$HOME/.zsh/ai.zsh"

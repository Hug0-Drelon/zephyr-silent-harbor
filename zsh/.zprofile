# POSIX shared environment (safe to source from any shell entry point).
emulate sh -c '. "$HOME/.zsh/env.sh"'

. "$HOME/.zsh/tools/homebrew.sh"

[ -f "$HOME/.orbstack/shell/init.zsh" ] && source "$HOME/.orbstack/shell/init.zsh"

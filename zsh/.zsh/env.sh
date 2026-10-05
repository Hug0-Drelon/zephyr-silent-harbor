# POSIX shared environment (safe to source from any shell entry point).
if [ -n "${SHELL_ENV_LOADED:-}" ]; then
	return 0 2>/dev/null || exit 0
fi

SHELL_ENV_LOADED=1
export SHELL_ENV_LOADED

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

. "$HOME/.zsh/tools/cargo.sh"

[ -f "$HOME/.zsh/env.local.sh" ] && . "$HOME/.zsh/env.local.sh"

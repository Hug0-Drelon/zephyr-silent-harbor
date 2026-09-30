# Load completion
if type brew &>/dev/null; then
	FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi
autoload -Uz compinit
compinit

# `npm run <tab>` autocompletion scripts from local package.json
if command -v npm >/dev/null; then
	source <(npm completion)
fi

# Auto-cd to directory when typing directory name
setopt autocd

# Enable extended globbing (e.g. `**/*.txt`)
# for commands like `ls`, `grep`, `rm`, `find`, `chmod`, etc.
setopt extendedglob

# History (defaults are small; tune here if needed)
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
# Append as you go; periodically re-write HISTFILE (dedupe via HIST_SAVE_NO_DUPS).
# Default APPEND_HISTORY-only exits leave many duplicate lines on disk.
setopt INC_APPEND_HISTORY

# Safer / nicer interactive shell
setopt NOCLOBBER
setopt RM_STAR_WAIT
setopt interactivecomments
setopt COMBINING_CHARS

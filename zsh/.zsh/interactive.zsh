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

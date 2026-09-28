source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source /opt/homebrew/share/zsh-history-substring-search/zsh-history-substring-search.zsh

# Up/down: CSI (Ghostty, Cursor) and SS3 (some terminals)
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[OA' history-substring-search-up
bindkey '^[OB' history-substring-search-down

if command -v zoxide >/dev/null; then
	eval "$(zoxide init zsh)"
fi

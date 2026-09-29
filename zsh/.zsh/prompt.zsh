# Git branch in prompt (first match wins; ANSI names from zsh Misc/colors):
#   yellow  — unstaged or untracked
#   cyan    — staged only
#   magenta — tracking upstream but ahead/behind/diverged
#   green   — clean working tree and in sync (or no upstream)
git_branch_prompt() {
	local branch color stats ahead behind

	branch=$(git branch --show-current 2>/dev/null) || return

	color=green

	# Check for unstaged/untracked changes
	if ! git diff --quiet 2>/dev/null ||
	   [ -n "$(git ls-files --others --exclude-standard 2>/dev/null)" ]; then
		color=yellow
	# Check for staged changes only
	elif ! git diff --cached --quiet 2>/dev/null; then
		color=cyan
	# Check for tracking upstream but ahead/behind/diverged
	elif git rev-parse --verify @{u} >/dev/null 2>&1; then
		# rev-list prints "ahead<TAB>behind" — split on whitespace, not only spaces
		stats=(${=$(git rev-list --left-right --count HEAD...@{u} 2>/dev/null)})
		ahead=${stats[1]:-0}
		behind=${stats[2]:-0}
		if [[ ${ahead:-0} -gt 0 || ${behind:-0} -gt 0 ]]; then
			color=magenta
		fi
	fi

	echo " %F{${color}}${branch}%f"
}

typeset -g _prompt_last_status=0

prompt_precmd() {
	_prompt_last_status=$?
}

# %F{8} dim $ or #; red on last exit ≠ 0 (not SIGINT / Ctrl+C → 130)
prompt_char_prompt() {
	local sig='$' color=8

	(( EUID == 0 )) && sig='#'
	if (( _prompt_last_status != 0 && _prompt_last_status != 130 )); then
		color=red
	fi

	echo " %F{${color}}${sig}%f"
}

precmd_functions+=(prompt_precmd)

setopt PROMPT_SUBST
PROMPT='%F{8}%n@%m%f %1~$(git_branch_prompt)$(prompt_char_prompt) '

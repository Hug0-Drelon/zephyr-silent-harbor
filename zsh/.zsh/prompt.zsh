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

setopt PROMPT_SUBST
PROMPT='%n@%m %1~$(git_branch_prompt) $ '

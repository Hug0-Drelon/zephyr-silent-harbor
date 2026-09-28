# Git branch in prompt: green when clean, yellow when dirty.
git_branch_prompt() {
	local branch

	branch=$(git branch --show-current 2>/dev/null) || return

	if git diff --quiet 2>/dev/null && git diff --cached --quiet 2>/dev/null && \
	   [ -z "$(git ls-files --others --exclude-standard 2>/dev/null)" ]; then
		echo " %F{green}${branch}%f"
	else
		echo " %F{yellow}${branch}%f"
	fi
}

setopt PROMPT_SUBST
PROMPT='%n@%m %1~$(git_branch_prompt) $ '

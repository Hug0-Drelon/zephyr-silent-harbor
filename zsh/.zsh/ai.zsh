# ai.zsh — Ollama: sync launchd env once per session.
# Skipped silently if ollama is not installed on this machine.
# Values live in env.local.sh (per-machine); unset vars are not applied.
# Must be sourced AFTER env.local.sh (it reads the OLLAMA_* values from it).
#
# One-time prerequisite (not handled here — add to README):
#   ollama create -f ollama/modelfiles/qwen3.5-9b-resident qwen3.5-9b-resident

_ollama_sync_launchd() {
	local _v _current
	local -a _ollama_vars _to_set
	_ollama_vars=(OLLAMA_KEEP_ALIVE OLLAMA_MAX_LOADED_MODELS OLLAMA_NUM_PARALLEL \
	              OLLAMA_FLASH_ATTENTION OLLAMA_KV_CACHE_TYPE OLLAMA_GPU_OVERHEAD)
	_to_set=()
	for _v in "${_ollama_vars[@]}"; do
		[[ -n "${(P)_v}" ]] || continue   # not defined on this machine → skip
		_current="$(launchctl getenv "$_v" 2>/dev/null)"
		[[ "$_current" != "${(P)_v}" ]] && _to_set+=("$_v")
	done
	if (( ${#_to_set[@]} > 0 )); then
		for _v in "${_to_set[@]}"; do
			launchctl setenv "$_v" "${(P)_v}"
		done
		# Restart the app only if running, so it re-reads launchd env
		if [[ -d "/Applications/Ollama.app" ]]; then # Check if Ollama.app is installed
			killall Ollama 2>/dev/null
			open -ga Ollama
		elif command -v brew >/dev/null 2>&1 && brew services list 2>/dev/null | grep -q '^ollama .*started'; then # Check if ollama is running via brew services
			brew services restart ollama
		else
			print -P "%F{red}zsh: Ollama is running but there is no way to restart it (neither Ollama.app nor brew services)%f" >&2
			return 1
		fi

	fi
}

if command -v ollama >/dev/null 2>&1 && [[ -z "${_OLLAMA_SYNCED:-}" ]]; then
	_OLLAMA_SYNCED=1
	_ollama_sync_launchd
fi

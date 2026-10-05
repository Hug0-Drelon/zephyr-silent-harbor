set -euo pipefail

SCRIPT_DIR="${0:A:h}"
MODELS_DIR="${SCRIPT_DIR}/modelfiles"

if [[ ! -d "${MODELS_DIR}" ]]; then
	print -P "%F{red}Error: models directory not found at ${MODELS_DIR}%f" >&2
	exit 1
fi

if ! command -v ollama >/dev/null 2>&1; then
	print -P "%F{red}Error: ollama is not installed%f" >&2
	exit 1
fi

count=0
for modelfile in "${MODELS_DIR}"/*(N); do
	variant="${modelfile:t}"
	print -P "%F{cyan}Creating variant '%F{bold}${variant}%f%F{cyan}' from ${modelfile}...%f"
	if ollama create -f "${modelfile}" "${variant}"; then
		print -P "%F{green}✔ Variant '${variant}' created.%f"
	else
		print -P "%F{red}✘ Failed to create variant '${variant}'.%f" >&2
		exit 1
	fi
	count=$((count + 1))
done

if (( count == 0 )); then
	print -P "%F{red}Error: no Modelfile found in ${MODELS_DIR}%f" >&2
	exit 1
fi

print -P "%F{green}Done: ${count} variant(s) created. Run 'ollama list' to see all variants.%f"

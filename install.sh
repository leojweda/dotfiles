#!/bin/bash

# -e: exit on error
# -u: exit on unset variables
# -f: disable file name generation (globbing)
# -o pipefail: exit on pipe error
set -eufo pipefail

# Install Homebrew if it's not installed
if ! command -v brew; then
	echo '🍺  Installing Homebrew' >&2 && \
	NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

	if [[ $OSTYPE == darwin* ]]; then
		eval "$(/opt/homebrew/bin/brew shellenv)"
	elif [[ $OSTYPE == linux* ]]; then
		eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
	else
		echo "Unsupported OS: ${OSTYPE}" >&2
		exit 1
	fi
fi

# POSIX way to get script's dir: https://stackoverflow.com/a/29834779/12156188
script_dir="$(cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P)"

echo '📦  Installing dependencies' >&2 && \
brew update && \
brew bundle --file="${script_dir}/dot_config/homebrew/Brewfile"

if [[ $OSTYPE == darwin* ]]; then
	brew bundle --file="${script_dir}/dot_config/homebrew/Brewfile.darwin"
fi

set -- init --apply --source="${script_dir}"

echo "🏠  Running 'chezmoi $*'" >&2 && \
exec chezmoi "$@"

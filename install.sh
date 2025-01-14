#!/bin/bash

# -e: exit on error
# -u: exit on unset variables
# -f: disable file name generation (globbing)
# -o pipefail: exit on pipe error
set -eufo pipefail

# Install Homebrew
command -v brew >/dev/null 2>&1 || \
	echo '📦  Installing Homebrew' >&2 && \
	NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

if ! chezmoi="$(command -v chezmoi)"; then
	if [[ $OSTYPE == darwin* ]]; then
		eval "$(/opt/homebrew/bin/brew shellenv)"
	elif [[ $OSTYPE == linux* ]]; then
		eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
	else
		echo "Unsupported OS: ${OSTYPE}" >&2
		exit 1
	fi

	echo '📦  Installing chezmoi' >&2 && \
	brew install chezmoi
fi

# POSIX way to get script's dir: https://stackoverflow.com/a/29834779/12156188
script_dir="$(cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P)"

set -- init --apply --source="${script_dir}"

echo "Running 'chezmoi $*'" >&2
# exec: replace current process with chezmoi
chezmoi "$@"

brew update
brew bundle

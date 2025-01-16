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

echo '📦  Installing dependencies' >&2 && \
brew update && \
brew bundle

# POSIX way to get script's dir: https://stackoverflow.com/a/29834779/12156188
script_dir="$(cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P)"

set -- init --apply --source="${script_dir}"

echo "🏠  Running 'chezmoi $*'" >&2 && \
chezmoi "$@"

if [[ $OSTYPE == linux* ]]; then
	echo '🔠  Installing JetBrains Mono Nerd Font' >&2 && \
	git clone --depth=1 https://github.com/ryanoasis/nerd-fonts.git /tmp/nerd-fonts && \
	cd /tmp/nerd-fonts && \
	./install.sh JetBrainsMono
fi

echo '🔧  Updating shell configuration' >&2 && \
source ~/.zshrc

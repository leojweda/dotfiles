#!/bin/bash

# -e: exit on error
# -u: exit on unset variables
# -f: disable file name generation (globbing)
# -o pipefail: exit on pipe error
set -eufo pipefail

# 🛠 Utility: print to stderr
log() {
  echo "$@" >&2
}

# 🍺 Install Homebrew if needed
install_homebrew() {
  if ! command -v brew >/dev/null; then
    log '🍺  Installing Homebrew'
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    case "$OSTYPE" in
      darwin*)  eval "$(/opt/homebrew/bin/brew shellenv)" ;;
      linux*)   eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" ;;
      *)        log "❌ Unsupported OS: $OSTYPE"; exit 1 ;;
    esac
  fi
}

# 📦 Install Brewfile dependencies
install_brewfile() {
  log '📦  Installing dependencies'
  brew update

  brew bundle --file="$1"

  if [[ $OSTYPE == darwin* ]]; then
    brew bundle --file="${1}.darwin"
  fi
}

# 🧪 Workaround: install unsupported packages manually on ARM Linux
install_arm64_linux_fallbacks() {
  if [[ "$OSTYPE" == linux* ]]; then
    local arch
    arch=$(uname -m)

    if [[ "$arch" == "arm64" || "$arch" == "aarch64" ]]; then
      sudo apt update

      for pkg in fzf gh; do
        if ! command -v "$pkg" >/dev/null; then
          log "🛠️  Installing $pkg manually"
          sudo apt install -y "$pkg"
        fi
      done

      if ! command -v oh-my-posh >/dev/null; then
        log '🛠️  Installing Oh My Posh manually'
        curl -s https://ohmyposh.dev/install.sh | bash -s
      fi
    fi
  fi
}

# 🏠 Run chezmoi
run_chezmoi() {
  if ! command -v chezmoi >/dev/null; then
    log "❌ chezmoi not found. Please install it first."
    exit 1
  fi

  set -- init --apply --source="$1"
  log "🏠  Running 'chezmoi $*'"
  exec chezmoi "$@"
}

# 🧠 Main script
main() {
  install_homebrew

  script_dir="$(cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P)"
  install_brewfile "${script_dir}/dot_config/homebrew/Brewfile"

  install_arm64_linux_fallbacks

  run_chezmoi "$script_dir"
}

main "$@"

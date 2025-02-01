if ! gh extension list 2>/dev/null | grep -q 'github/gh-copilot'; then
    echo "Installing GitHub CLI Copilot extension..."
    gh extension install github/gh-copilot
fi

eval "$(gh copilot alias -- zsh)"

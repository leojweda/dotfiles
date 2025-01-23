alias k9='kill -8'

alias ls='eza --icons --group-directories-first'
alias ll='ls --git -l'
alias la='ls --git -la'

alias -g -- -h='-h 2>&1 | bat --language=help --style=plain'
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias -- -='cd -'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias _='sudo'
alias mkdir='mkdir -p'
alias sa='alias | grep -i'

alias o='open'
alias pbc='pbcopy'

# Show/hide hidden files in the Finder
alias showfiles='defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder'
alias hidefiles='defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder'

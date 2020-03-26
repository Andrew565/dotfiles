# ***** Andrew's .bashrc file *****
# There are many like it, but this one's mine.
# https://andrewthecreator.com

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# ***** History Searching with Up and Down keys *****

bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

# ***** Basic Environment Setup *****

# Setup Path Vars
export PATH=$(brew --prefix coreutils)/libexec/gnubin:~/Projects/operations/bin:$PATH
export CDPATH=".:${HOME}/Projects"

# Prefer US English and use UTF-8
export LC_ALL="en_US.UTF-8"
export LANG="en_US"

# Use VSC as editor (instead of vim)
export EDITOR='code -w'

# wrap git with hub
eval "$(hub alias -s)"

# source git-completion
source "/Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash"

# ***** MERCURIAL FUNCTIONS *****

# commit and close in one
# hgcc() {
#   CURRENT=`hg branch`
#   hg commit -m "$1 $CURRENT" --close-branch
# }

# create new branch from a default named branch
# modify the first line to make it an argument if desired
# hgnew() {
#   DEST_BRANCH=$2
#   : ${DEST_BRANCH:='PCC'}
#   hg up $DEST_BRANCH
#   hg branch "$1"
#   hg commit -m "Started $1 branch"
#   hg push --new-branch
# }

# commit and append the current branch automatically
# hgc() {
#   # get current branch name
#   CURRENT=`hg branch`
#   hg commit -m "$1 $CURRENT"
# }

# merge current branch into
# hgmac() {
#   # get current branch name
#   CURRENT=`hg branch`
#   DEST_BRANCH=$2
#   : ${DEST_BRANCH:='PCC'}
#   hg up $DEST_BRANCH
#   hg merge $CURRENT
#   hg commit -m "Merged $CURRENT branch"
# }

# ***** Git Functions *****

# create new branch from either a named branch or the current one
gnew() {
  PARENT_BRANCH=$2
  CURRENT=`git rev-parse --abbrev-ref HEAD` # figures out the current branch
  : ${PARENT_BRANCH:=$CURRENT} # If no parent branch argument was provided, use the current branch
  git co $PARENT_BRANCH # Checkout and update the parent
  git pull
  git co -b "$1" # Branch off of the parent
  git push -u origin "$1" # Immediately push to set up tracking
}

# Switch branches by issue number or feature keyword
# For example: gswitch 1808 == git checkout features/1808-click-on-avatar
# NOTE: only works well if you use a unique description, thus the
# recommendation to use the issue number
gswitch() {
  BRANCH=`git branch | grep -m 1 "$1"` # returns first match
  git checkout $BRANCH
}

stashlist() { git stash list -n ${1-10}; }

# ***** Other Bash Functions *****

# finds runaway processes by name and kills them
assassinate() {
  ps ax | grep "$1" | grep -v grep | cut -f1 -d ' ' | xargs kill
}

# ***** ALIASES *****

# Git Aliases
alias g="git"
alias gcm="gmupdate"
alias gcmm="git checkout --"
alias gitnew="gnew"
alias gl="git log"
alias glatest="git co development && git pull"
alias gmd="git merge development"
alias gmm="git merge origin/master"
alias gmupdate="git co master && git pull"
alias go="git checkout"
alias gpf="git push -f"
alias gpull="git pull"
alias gpush="git push"
alias grc="git rebase --continue"
alias grh="git reset --hard"
alias grm="git rebase origin/master"
alias grs="git rebase --skip"
alias gs="git status"
alias gsd="git stash && git co development"
alias gsl="git stash list"
alias gsm="git stash && git co master && git stash pop"
alias gsp="git stash pop"
alias gsrm="git stash && grm && git stash pop"
alias gss="git stash"
alias gsum="git stash && gmm && git stash pop"
alias gupdate="git co development && git pull"
# alias gphm="git push heroku master"

# Mercurial (hg) Aliases
# alias hs="hg status"
# alias hgs="hg status"
# alias hgsum="hg summary"
# alias hgar="hg addremove"
# alias hgg="open /Applications/MacHg.app"
# alias hgp="hg push || hg push --new-branch"
# alias hgpush="hgp"
# alias hgpn="hg push --new-branch"
# alias hgpu="hg pull && hg update"
# alias hgpullup="hgpu"
# alias pullup="hgpu"
# alias hgl="hg log -l 4 | grep summary"
# alias hglc="hg log -l 4 | grep changeset"

# Ember Aliases
# alias e="ember"
# alias es="ember server"
# alias eib="ember install:bower"
# alias ein="ember install:npm"
# alias eg="ember generate"
# alias ed="ember destroy"

# Basic Aliases
alias ..="cd .."
alias cd..="cd .."
alias p="cd ~/Projects"
alias h="history"
# alias a="atom" # atom
# alias a.="atom ." # atom
alias o="open"
alias o.="open ."
# alias s="subl"
# alias s.="subl ."
# alias ws.="ws ." # WebStorm
alias sudo="sudo " # allows sudo in aliases, IIRC

# NPM Scripts Aliases
alias ns="npm start"
alias nrb="npm run build"
alias nt="npm test"

# Yarn Aliases
alias yas="yarn start"
alias yb="yarn build"
alias ydc="yarn dc-start"
alias yi="yarn install"
alias yl="yarn lint"
alias ysl="yarn start"
alias yt="yarn test"
alias ytc="yarn coverage"
alias yti="yarn test:integration"
alias ytip="yarn run jest -c integration/jest.config.js -t"
alias ytp="yarn test --testPathPattern"
alias ytpc="yarn coverage --testPathPattern"
alias yps="yarn proxy-start"

# Electron Aliases
alias nre="npm run electron"
alias be="npm run build && npm run electron"

# Bundle/Rails Aliases
# alias be="bundle exec"
# alias becc="bundle exec rake canvas:compile_assets"
# alias berdbm="bundle exec rake db:migrate"
# alias berdm="berdbm"
# alias migrate="bundle exec rake db:migrate"
# alias checkfornew="bundle install && migrate"
# alias cfn="checkfornew"
# alias ber="bundle exec rails"
# alias berc="bundle exec rails console"
# alias berg="bundle exec rails generate"
# alias bers="bundle exec rails server"
# alias besc="bundle exec script/console"
# alias besg="bundle exec script/generate"
# alias bess="bundle exec script/server"
# alias engarde="bundle exec guard"
# alias fs="foreman start"
# alias prod="RAILS_ENV=production"

# Docker Aliases
alias dcu="docker-compose down && docker-compose build && docker-compose up"

# Grep Aliases
alias grep="grep --color=auto"
alias findprocess="ps -ax | grep -v grep | grep"
alias hist="history | grep"

# Open .bashrc for editing, then save
alias editbash="code ~/.bashrc"
alias sourcebash="source ~/.bashrc"

# Empty trash and clear system logs
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"

# Show/hide hidden files in Finder
alias showfiles="defaults write com.apple.Finder AppleShowAllFiles -bool true && killall Finder"
alias hidefiles="defaults write com.apple.Finder AppleShowAllFiles -bool false && killall Finder"
alias showlibrary="/usr/bin/chflags nohidden ~/Library"

# Hide/show all desktop icons (useful when presenting)
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

# Focus Mode (aka Single App Mode)
alias focusmode="defaults write com.apple.dock single-app -bool true && killall Dock"
alias focusmodeoff="defaults write com.apple.dock single-app -bool false && killall Dock"


# ***** LS Tweaks *****

# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
  colorflag="--color"
else # OS X `ls`
  colorflag="-G"
fi

# List all files colorized in long format, including dot files
alias la="ls -la ${colorflag}"

# List only directories
alias lsd='ls -l ${colorflag} | grep "^d"'

# Always use color output for `ls`
alias ls="command ls ${colorflag}"
export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'

# ***** PROMPT Tweaks *****

# Set up ANSI colors for prompt
RED="\033[31m"
PINK="\033[1;31m"
MUSTARD="\033[33m"
YELLOW="\033[1;33m"
GREEN="\033[32m"
PURPLE="\033[35m"
WHITE="\033[1;37m"
CYAN="\033[1;36m"
BOLD=""
RESET="\033[m"

export RED
export PINK
export MUSTARD
export YELLOW
export GREEN
export PURPLE
export WHITE
export CYAN
export BOLD
export RESET

# Function for determining git status for use in prompt.
# Changes color based on status:
# * Green = Nothing to commit
# * Yellow = Some changes committed but not yet pushed
# * Magenta = Uncommitted changes present
# If on master, just displays a box, otherwise displays branch name
function _git_prompt() {
  local git_status="`git status -unormal 2>&1`"
  if ! [[ "$git_status" =~ Not\ a\ git\ repo ]]; then
    if [[ "$git_status" =~ nothing\ to\ commit ]]; then
      local ansi=$GREEN
    elif [[ "$git_status" =~ nothing\ added\ to\ commit\ but\ untracked\ files\ present ]]; then
      local ansi=$WHITE
    else
      local ansi=$RED
    fi
    if [[ "$git_status" =~ On\ branch\ ([^[:space:]]+) ]]; then
      branch=${BASH_REMATCH[1]}
      test "$branch" != master || branch=' '
    else
      # Detached HEAD. (branch=HEAD is a faster alternative.)
      branch="(`git describe --all --contains --abbrev=4 HEAD 2> /dev/null ||
        echo HEAD`)"
    fi
    echo -n '\['"$ansi"'\]\W\['"${RESET}"'\] '
  fi
}

# function _hg_prompt() {
#   local hg_status="`hg sum 2>&1`"
#   if ! [[ "$hg_status" =~ no\ repository\ found ]]; then
#     local branch="`hg sum | grep branch: | cut -d ":" -f 2`"
#     echo -n "$branch"
#   fi
# }

# My Prompt which looks kind of like: my_project development 🔥
# (The current command number@The current time) current directory git_prompt 🔥 (emoji fire symbol).
# Use \! for the current command (useful for history searching or re-running a command using !554)
# \A for current time in hours and minutes (24-hour time)
# \W for current working directory
function _prompt_command() {
  PS1="$(_git_prompt)🔥  "
}
PROMPT_COMMAND=_prompt_command

# This loads a random fortune (`brew install fortune`) the first time the environment loads
if [ "$PS1" ]; then
  echo -e "$(fortune)"
fi

# Installs some handy default settings
install_defaults() {
  # Show all files in Finder
  defaults write com.apple.Finder AppleShowAllFiles -bool true

  # Don't hide the Library folder in Finder
  /usr/bin/chflags nohidden ~/Library

  # Show only open applications in the dock
  defaults write com.apple.dock static-only -bool false

  # Wipe all (default) app icons from the Dock
  defaults write com.apple.dock persistent-apps -array

  # Set the icon size of Dock items to 16 pixels
  defaults write com.apple.dock tilesize -int 16

  # Set the magnification to true
  defaults write com.apple.dock magnification -int 1

  # show the date in the toolbar
  defaults write com.apple.menuextra.clock DateFormat -string 'EEE MMM d  H:mm'

  # Set alert volume to 0
  defaults write NSGlobalDomain com.apple.sound.beep.volume -float 0.0

  # reboot systemUIServer to enable defaults to take effect
  killall SystemUIServer

  # Fixes subpixel anti-aliasing on Mojave
  defaults write -g CGFontRenderingFontSmoothingDisabled -bool FALSE
}

# Installs homebrew and/or some useful brew defaults
install_brew_stuff() {
  # Install brew if not already installed
  if ! command -v brew >/dev/null; then
    fancy_echo "Installing Homebrew ..."
      curl -fsS \
        'https://raw.githubusercontent.com/Homebrew/install/master/install' | ruby
  fi

  brew install awscli
  brew install fortune
  brew install hub
  brew install jq
  brew install openssl

  # Casks
  brew tap caskroom/cask
  brew cask install alfred
  brew cask install iterm2
  brew cask install keybase
  brew cask install kindle
  brew cask install spotify
}

install_other_stuff() {
  # Make git use the osx keychain
  git config --global credential.helper osxkeychain
}

setup_new_computer() {
  install_defaults
  install_brew_stuff
  install_other_stuff
}

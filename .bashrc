# ***** Andrew's .bashrc file *****
# There are many like it, but this one's mine.
# https://andrewthecreator.com

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# ***** History Searching with Up and Down keys *****

bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

# ***** Basic Environment Setup *****

# Setup Path Vars
export PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH
export CDPATH=".:${HOME}/Projects"

# Prefer US English and use UTF-8
export LC_ALL="en_US.UTF-8"
export LANG="en_US"

# Use Sublime Text as editor (instead of vim)
export EDITOR='code -w'

# Bash Completions
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# ***** ANYBAR FUNCTIONS *****
# . "/Users/andrew/Projects/Andrew/anybar-icon-journal/anybar.sh"

# ***** StatusItem Functions *****
# alias si="StatusItem -r"

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

# "deploy" latest SDE Admin changes by committing to solutions repo
# hgmad() {
#   CURRENT=`hg log -l 1 | grep summary | cut -d" " -f 7`
#   cd ~/Projects/sde/
#   hg pull
#   hg up
#   hg commit -m "Deploying SDE Admin, last branch committed: $CURRENT"
#   hg push
#   cd ~/Projects/sde/sde-admin/
# }

# ***** Git Functions *****

# create new branch from a default named branch
# modify the first line to make it an argument if desired
gnew() {
  DEST_BRANCH=$2
  : ${DEST_BRANCH:='master'}
  git co $DEST_BRANCH
  git pull
  git co -b "$1"
  # bundle install # If using Bundler (ruby)
  # bundle exec rake db:migrate
  git push -u origin "$1"
}

# Get the latest changes on master pulled down locally
# and then rebase them into/onto the current branch
grm() {
  CURRENT=`git rev-parse --abbrev-ref HEAD` # figures out the current branch
  git checkout master
  git pull
  git checkout $CURRENT
  git rebase master
}

# Stash current, then update to latest, then pop the stash
gsrm() {
  git stash
  grm
  git stash pop
}

# Switch branches by issue number or feature keyword
# For example: gswitch 1808 == git checkout features/1808-click-on-avatar
# NOTE: only works well if you use a unique description, thus the
# recommendation to use the issue number
gswitch() {
  BRANCH=`git branch | grep "$1"`
  git checkout $BRANCH
}

# ***** Other Bash Functions *****

# finds runaway processes by name and kills them
assassinate() {
  ps ax | grep "$1" | grep -v grep | cut -f1 -d ' ' | xargs kill
}

# ***** ALIASES *****

# Git Aliases
alias g="git"
alias gs="git status"
alias gl="git log"
alias go="git checkout"
alias gitnew="gnew"
alias gpull="git pull"
alias gpush="git push"
alias gpf="git push -f"
alias grh="git reset --hard"
alias grc="git rebase --continue"
alias gcmm="git checkout --"
alias gsm="git stash && git co master && git stash pop"
alias gsd="git stash && git co development"
alias gmd="git merge development"
alias gmm="git merge master"
# alias gupdate="git co development && git pull"
# alias glatest="git co development && git pull"
alias gmupdate="git co master && git pull"
alias gcm="gmupdate"
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
# alias hgcl="hgc 'Merged latest from PCC to'"
# alias hgml="hg merge PCC && hgcl"
# alias hgl="hg log -l 4 | grep summary"
# alias hglc="hg log -l 4 | grep changeset"

# Ember Aliases
# alias e="ember"
# alias es="ember server"
# alias eib="ember install:bower"
# alias ein="ember install:npm"
# alias eg="ember generate"
# alias ed="ember destroy"
# alias ebp="ember build -o ../../resource-bundles/Ember.resource/ -prod"
# alias ebd="ember build -o ../../resource-bundles/Ember.resource/"

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

# Electron Aliases
alias nrb="npm run build"
alias nre="npm run electron"
alias ns="npm start"
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
# alias regenNotes="be rake notifications:clear_notification_groups && be rake notifications:generate_notification_groups"
# alias prod="RAILS_ENV=production"

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
      local ansi=42
    elif [[ "$git_status" =~ nothing\ added\ to\ commit\ but\ untracked\ files\ present ]]; then
      local ansi=43
    else
      local ansi=45
    fi
    if [[ "$git_status" =~ On\ branch\ ([^[:space:]]+) ]]; then
      branch=${BASH_REMATCH[1]}
      test "$branch" != master || branch=' '
    else
      # Detached HEAD. (branch=HEAD is a faster alternative.)
      branch="(`git describe --all --contains --abbrev=4 HEAD 2> /dev/null ||
        echo HEAD`)"
    fi
    echo -n '\[\e[0;31;'"$ansi"';1m\]'"$branch"'\[\e[0m\] '
  fi
}

# function _hg_prompt() {
#   local hg_status="`hg sum 2>&1`"
#   if ! [[ "$hg_status" =~ no\ repository\ found ]]; then
#     local branch="`hg sum | grep branch: | cut -d ":" -f 2`"
#     echo -n "$branch"
#   fi
# }

# My Prompt which looks kind of like: (554@12:16) ~/Projects/my_project development 🔥
# (The current command number@The current time) current directory git_prompt 🔥 (emoji fire symbol).
# Use \! for the current command (useful for history searching or re-running a command using !554)
# \A for current time in hours and minutes (24-hour time)
# \W for current working directory
function _prompt_command() {
  PS1="(\[${YELLOW}\]\A\[${RESET}\]) \W $(_git_prompt)🔥 \[${RESET}\] "
}
PROMPT_COMMAND=_prompt_command

# This loads a random fortune (`brew install fortune`) the first time the environment loads
if [ "$PS1" ]; then
  echo -e "$(fortune)"
fi

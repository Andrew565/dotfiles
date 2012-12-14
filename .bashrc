# ***** Andrew's .bashrc file *****
# There are many like it, but this one's mine.
# http://vizify.com/andrew-steele



# ***** Basic Environment Setup *****

# Setup Path Vars
export PATH="/usr/local/bin:/usr/local/sbin:/usr/local/Cellar/ruby/1.9.3-p194/bin:/usr/local/mysql/bin:~/bin:$PATH"

# Prefer US English and use UTF-8
export LC_ALL="en_US.UTF-8"
export LANG="en_US"

# Use Sublime Text 2 as editor (instead of vim)
export EDITOR='subl -w'

# Bash Completions
if [ -f $(brew --prefix)/etc/bash_completion ]; then
	. $(brew --prefix)/etc/bash_completion
fi
source ~/bash_completion.d/git-completion.bash
source ~/bash_completion.d/legit.bash



# ***** ALIASES *****

# Git Aliases
alias g="git"
alias gs="git status"
alias gsl="git smart-log"
alias gl="git smart-log"
alias gpull="git smart-pull origin"
alias gpush="git push origin"
alias grh="git reset --hard"
alias gpd="git reset wp-config.php && gpush && cap deploy"
alias gpcd="git reset wp-config.php && gpush && cap deploy"

# Basic Aliases
alias ..="cd .."
alias cd..="cd .."
alias p="cd ~/Projects"
alias h="history"
alias s="subl"
alias o="open"
alias o.="open ."
alias sudo="sudo "

# Open .bashrc for editing, then save
alias editbash="subl ~/.bashrc"
alias sourcebash="source ~/.bashrc"

# Empty trash and clear system logs
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"

# Show/hide hidden files in Finder
alias showfiles="defaults write com.apple.Finder AppleShowAllFiles -bool true && killall Finder"
alias hidefiles="defaults write com.apple.Finder AppleShowAllFiles -bool false && killall Finder"

# Hide/show all desktop icons (useful when presenting)
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

# Use screensaver as wallpaper
alias use_saver="/System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine -background &"
alias saver_off="ps ax | grep ScreenSaver | grep -v grep | cut -f1 -d ' ' | xargs kill"



# ***** LS Tweaks *****

# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
	colorflag="--color"
else # OS X `ls`
	colorflag="-G"
fi

# List all files colorized in long format
alias l="ls -l ${colorflag}"

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
            # Detached HEAD.  (branch=HEAD is a faster alternative.)
            branch="(`git describe --all --contains --abbrev=4 HEAD 2> /dev/null ||
                echo HEAD`)"
        fi
        echo -n '\[\e[0;37;'"$ansi"';1m\]'"$branch"'\[\e[0m\] '
    fi
}

# My Prompt which looks kind of like: (554@12:16) ~/Projects/my_project development 𐆗
# (The current command number@The current time) current directory git_prompt 𐆗 (random symbol I liked).
# Use \! for the current command (useful for history searching or re-running a command using !554)
# \A for current time in hours and minutes (24-hour time)
# \w for current working directory path, truncated if too long
function _prompt_command() {
    PS1="(\[${MUSTARD}\]\!\[${PURPLE}\]@\[${GREEN}\]\A\[${RESET}\]) \w \[${GREEN}\]$(_git_prompt)\[${PURPLE}\]𐆗\[${RESET}\] "
}
PROMPT_COMMAND=_prompt_command

# This loads a random fortune (`brew install fortune`) the first time the environment loads
if [ "$PS1" ]; then
	echo -e "${CYAN}$(fortune)${RESET}"
fi
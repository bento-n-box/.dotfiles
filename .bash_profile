export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/share/npm/bin:$PATH
export PATH=${PATH}:/var/lib/gems/1.8/bin/
export PATH=${PATH}:/var/lib/gems/
export PATH=$PATH:/usr/local/Cellar/ruby/1.9.3-p385/bin

export PATH=~/bin:$PATH
export PATH=/opt/subversion/bin:$PATH
export PATH="$PATH:/Users/bentonrr/Sites/Amex/trunk/www/lib/Cake/Console"
export NODE_PATH=/usr/local/lib/node_modules:/usr/local/lib/node



alias ls="ls -H"
alias ll="ls -lh"
alias l="ll"
alias lll="ll"
alias la="ll -a"
alias lla="ll -a"
alias lsa="ls -a"
alias lt='ll -t'
alias lrt='ll -rt'
alias lart="ll -lart"
alias lsd="ls -d */"
alias lld="ll -d */"

alias git+st="git status"


function detect_git_dirty {
  local git_status=$(git status 2>&1 | tail -n1)
  [[ $git_status != "fatal: Not a git repository (or any of the parent
  directories): .git" ]] && [[ $git_status != "nothing to commit (working
  directory clean)" ]] && echo "*"
}

function detect_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1/"
}
function dev_info {
  echo "[$(detect_git_branch)$(detect_git_dirty)]"
}

# quick commands
alias tails='tail -f /Applications/MAMP/logs/apache_error.log'
alias ebash='vim ~/.bash_profile'
alias rebash='. ~/.bash_profile'
alias ehosts='sudo mvim /etc/hosts'
alias tmamp='tail -f /Applications/MAMP/logs/*';
alias tache='tail -f /var/log/apache2/*';
alias vimrc='vim ~/.vimrc'
alias gvimrc='vim ~/.gvimrc'
alias rmlogs="sudo rm -f /private/var/log/asl/*.asl"
alias ephp="sudo vim /etc/php.ini"
alias apr="sudo apachectl restart"
alias iphone="open /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Applications/iPhone\ Simulator.app"



 BLACK="\[\033[0;30m\]"
 RED="\[\033[0;31m\]"
 GREEN="\[\033[1;32m\]"
 YELLOW="\[\033[1;33m\]"
 BLUE="\[\033[0;34m\]"
 PURPLE="\[\033[0;35m\]"
 CYAN="\[\033[0;36m\]"
 WHITE="\[\033[0;37m\]"
 
export PS1="${GREEN}\u ${YELLOW}\w ${BLUE}\W ${CYAN}\$(dev_info)${WHITE}\$ "
# tell ls to be colourful
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

# Set git autocompletion and PS1 integration
if [ -f /usr/local/git/contrib/completion/git-completion.bash ]; then
  . /usr/local/git/contrib/completion/git-completion.bash
fi
if [ -f /opt/local/share/doc/git-core/contrib/completion/git-prompt.sh ]; then
    . /opt/local/share/doc/git-core/contrib/completion/git-prompt.sh
fi
GIT_PS1_SHOWDIRTYSTATE=true

if [ -f /opt/local/etc/bash_completion ]; then
    . /opt/local/etc/bash_completion
fi
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

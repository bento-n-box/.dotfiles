# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
export NODE_PATH="/usr/local/lib/node"
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/share/npm/bin:$PATH
export PATH=$PATH:/usr/local/Cellar/ruby/1.9.3-p385/bin


# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="af-magic"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

alias tails='tail -f log/development.log'
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

alias gs="git status"
alias gp="git push origin"



PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

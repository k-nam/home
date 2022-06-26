# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git copyfile)

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

PROMPT='%B%F{cyan}%~%f%b '

BIN_DIR=~/bin

alias ll='ls -alh'
alias free='free -h'
alias du='du -h'
alias df='df -h'

alias q='screen -r'
alias ql='screen -ls'

alias vv='source .env/bin/activate'

alias rmm="$BIN_DIR/rmm.sh"
alias rm="echo 'NG'"
alias rm_real="$BIN_DIR/rmreal.sh"

alias speed="$BIN_DIR/speedtest.sh"
alias dump="$BIN_DIR/mysql_dump.sh"

alias gch="git checkout"
alias gs="git status"
alias gr="git reset"
alias gb="git branch --all"
alias gaa="git add -A"
alias gc="git commit --allow-empty"
alias gps="git push"
alias gpl="git pull --all"
alias gm="git merge --no-ff --no-commit"
alias gf="git fetch --all --prune"
alias gt="$BIN_DIR/gt.sh"
alias gl="git log"
alias gpsf="$BIN_DIR/gpsf.sh"
alias gpsl="$BIN_DIR/gpsl.sh"
alias gpse="git commit --allow-empty -m 'empty' && git push"

alias dc='shell/dc.sh'
alias dupbd='dc up --build -d'
alias di='docker images'
alias dps='docker ps'
alias dn='docker network'
alias dprune='docker container prune -f && docker image prune -f'

alias ecs="shell/ecs_deploy.sh"
alias sls="serverless"
alias rea="shell/react_deploy.sh"
alias dep="shell/deploy.sh"

alias nd='../shell/nd.sh'
alias ns='../shell/ns.sh'

alias res='shell/res.sh'
alias reb='../shell/reb.sh'

alias gd='shell/gd.sh'

alias nr='$BIN_DIR/nr.sh'
alias lint='npm run lint'

alias snsdoc='$BIN_DIR/sns.sh'

alias rd='((export $(cat env/env-${HW_ENV}.sh && source secret/secret.sh) && rails s --binding 0.0.0.0 -p $(eval echo \$$(basename ${PWD^^}_PORT))))'
alias rp='((export $(cat env/env-${HW_ENV}.sh && source secret/secret.sh) && bundle exec rake assets:precompile RAILS_ENV=production && rails s --binding 0.0.0.0 -p $(eval echo \$$(basename ${PWD^^}_PORT))))'


alias killport='$BIN_DIR/killport.sh'

alias port='sudo lsof -i -P -n | grep LISTEN'

alias ctl="sudo systemctl"

alias mysqlssh="$BIN_DIR/mysqlssh.sh"
alias mysqlclient="mysql -h 127.0.0.1 -udev -pcalvin1729"

alias vv='source venv/bin/activate'

alias tp='terraform plan -var-file="`terraform workspace show`.tfvars"'
alias te='$BIN_DIR/te.sh'
alias td='terraform destroy -var-file="`terraform workspace show`.tfvars"'
alias tw='terraform workspace show'
alias tws='terraform workspace select'
alias twl='terraform workspace list'
alias tfm='terraform fmt -recursive'
alias ts='terraform state'
alias aa='. $BIN_DIR/aws_account.sh'
alias ac='. $BIN_DIR/ab.sh'
alias gcp='. $BIN_DIR/gcp.sh'

alias start='$BIN_DIR/start.sh'
alias stop='$BIN_DIR/stop.sh'

export PATH=${PATH}:/usr/local/go/bin:~/go/bin

export HW_ENV=mac
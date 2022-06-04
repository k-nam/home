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

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

source /etc/profile.d/rvm.sh

export PATH=${PATH}:/usr/local/go/bin
export PATH=${PATH}:`go env GOPATH`/bin

# Export the Android SDK path
export ANDROID_HOME=$HOME/android-sdk
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

# Fixes sdkmanager error with java versions higher than java 8
export JAVA_OPTS='-XX:+IgnoreUnrecognizedVMOptions --add-modules java.se.ee'

# export GOOGLE_APPLICATION_CREDENTIALS="/home/calvin/gcp_sa_key/f-admin.json"
export PATH="$PATH:/usr/lib/dart/bin"

go env -w GOPRIVATE=github.com/flicspy/*,github.com/f-*

eval `ssh-agent` > /dev/null
ssh-add ~/.ssh/id_rsa_knam 2>/dev/null

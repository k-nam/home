BIN_DIR=~/dev/calvincaulfield/home/bin

alias free='free -h'
alias du='du -h'
alias df='df -h'

alias q='screen -r'
alias ql='screen -ls'

alias python=python3
alias pip=pip3
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
alias gc="git commit"
alias gps="git push"
alias gpl="git pull --all"
alias gm="git merge"
alias gf="git fetch --all --prune"
alias gt="$BIN_DIR/gt.sh"
alias gl="git log"
alias gpsf="$BIN_DIR/gpsf.sh"
alias gpse="git commit --allow-empty -m 'empty' && git push"

alias dc='shell/dc.sh'
alias dupbd='dc up --build -d'
alias di='docker images'
alias dps='docker ps'
alias dn='docker network'
alias dprune='docker container prune -f && docker image prune -f'

alias ecs="shell/ecs_deploy.sh"
alias sls="shell/sls_deploy.sh"

alias nd='../shell/nd.sh'
alias ns='../shell/ns.sh'

alias gd='../../shell/gd.sh'

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

alias tfp='terraform plan -var-file="`terraform workspace show`.tfvars"'
alias tfa='terraform apply -var-file="`terraform workspace show`.tfvars"'
alias tfd='terraform destroy -var-file="`terraform workspace show`.tfvars"'
alias tfw='terraform workspace show'
alias tfws='terraform workspace select'
alias tfwl='terraform workspace list'


export HW_ENV=ec2

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

source /etc/profile.d/rvm.sh

export PATH=${PATH}:`go env GOPATH`/bin
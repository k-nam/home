alias free='free -h'
alias du='du -h'
alias df='df -h'

alias q='screen -r'
alias ql='screen -ls'

alias python=python3
alias pip=pip3
alias vv='source .env/bin/activate'

alias rmm="~/dev/home/bin/rmm.sh"
alias rm="echo 'NG'"
alias rm_real="~/dev/home/bin/rmreal.sh"

alias speed="~/dev/home/bin/speedtest.sh"
alias dump="~/dev/home/bin/mysql_dump.sh"

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
alias gt="~/dev/home/bin/gt.sh"
alias gl="git log"
alias gpsf="git push --set-upstream origin"

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

alias nr='~/dev/home/bin/nr.sh'
alias lint='npm run lint'

alias snsdoc='~/dev/home/bin/sns.sh'

alias rd='((export $(cat env/env-${HW_ENV}.sh && source secret/secret.sh) && rails s --binding 0.0.0.0 -p $(eval echo \$$(basename ${PWD^^}_PORT))))'
alias rp='((export $(cat env/env-${HW_ENV}.sh && source secret/secret.sh) && bundle exec rake assets:precompile RAILS_ENV=production && rails s --binding 0.0.0.0 -p $(eval echo \$$(basename ${PWD^^}_PORT))))'


alias killport='~/dev/home/bin/killport.sh'

alias ctl="sudo systemctl"

alias mysqlssh="~/dev/home/bin/mysqlssh.sh"
alias mysqlclient="mysql -h 127.0.0.1 -udev -pcalvin1729"

alias vv='source venv/bin/activate'

alias tf='../shell/tf.sh'
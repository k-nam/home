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
alias gpl="git pull"
alias gm="git merge"
alias gf="git fetch --all --prune"
alias gt="~/dev/home/bin/gt.sh"
alias gl="git log"
alias gpsf="git push --set-upstream origin"

alias dc='export $(cat ./env/.env-${DEV_ENV} | xargs) && docker-compose -f docker-compose-dev.yml'
alias dupbd='export $(cat ./env/.env-${DEV_ENV} | xargs) && docker-compose -f docker-compose-dev.yml up -d --build'
alias di='docker images'
alias dps='docker ps'
alias dn='docker network'
alias dprune='docker container prune -f && docker image prune -f'

alias deploy='~/dev/home/bin/deploy_movie.sh'

alias nd='(export $(cat ../env/.env-${DEV_ENV} | xargs) && npm run dev)'
alias np='(export $(cat ../env/.env-${DEV_ENV} | xargs) && npm run start)'
alias snsdoc='~/dev/home/bin/sns.sh'

alias rd='(export $(cat ./.env/.env-${DEV_ENV} | xargs) && rails s --binding 0.0.0.0 -p $(eval echo \$$(basename ${PWD^^}_PORT)))'
alias rp='(export $(cat ./.env/.env-prod | xargs) && bundle exec rake assets:precompile RAILS_ENV=production && rails s --binding 0.0.0.0 -p $(eval echo \$$(basename ${PWD^^}_PORT)))'


alias killport='~/dev/home/bin/killport.sh'

alias ctl="sudo systemctl"

alias mysqlssh="~/dev/home/bin/mysqlssh.sh"
alias mysqlclient="mysql -h 127.0.0.1 -udev -pcalvin1729"

alias vv='source venv/bin/activate'
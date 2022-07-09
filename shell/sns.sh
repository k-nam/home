set -x
cd gateway && npm i && cd -
cd nextjs && npm i && cd -
cd api && npm i && cd -
docker-compose -f docker-compose-stage.yml up -d --build

set -eux

DATABASE=$1
USER=$2
PASSWORD=$3
FILE=${DATABASE}_$(date +%F_%a_%H-%M-%S_%Z).sql
FILE_GZ=$FILE.gz

mysqldump -h127.0.0.1 -P3307 -u$USER -p$PASSWORD --databases $DATABASE --set-gtid-purged=OFF --verbose --routines --events --triggers \
| pv | gzip > $FILE_GZ

# aws s3 mv $FILE_GZ s3://calvin-db-backup

# Code for restore DB with dumped sql
# Look for the password manually in AWS Console ssm
gunzip -c flicspy_2022-02-16_Wed_10-27-26_UTC.sql.gz | pv | mysql -h127.0.0.1 -P3307 -uroot -pXXXX

gunzip -c ~/dev/db_dump/flicspy_2022-02-16_Wed_10-27-26_UTC.sql.gz | pv | mysql -h34.84.74.184 -uroot -proot
#!/bin/sh

if [ -d /apps/opt/mysql ]; then
  echo "[i] MySQL data directory is already present, skiping creation"
else
  echo "[i] MySQL data directory not found, creating initial DBs"

  if [ ! -d "/apps/log/mysql" ]; then
    mkdir -p /apps/log/mysql
  fi

  mysql_install_db --user=root > /dev/null
  
  if [ "$MYSQL_ROOT_PASSWORD" = "" ]; then
    MYSQL_ROOT_PASSWORD = "zto123"
    echo "[i] MySQL root password: $MYSQL_ROOT_PASSWORD"
  fi

  MYSQL_DATABASES=${MYSQL_DATABASES:-""}
  MYSQL_USER=${MYSQL_USER:-""}
  mysql_PASSWORD=${MYSQL_PASSWORD:-""}

  if [ ! -d "/run/mysqld" ]; then
    mkdir -p /run/mysqld
  fi

  tfile=`mktemp`
  if [ ! -f "$tfile" ]; then
    return 1
  fi

  cat > $tfile <<EOF
USE mysql;
FLUSH PRIVILEGES;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY "$MYSQL_ROOT_PASSWORD" WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;
UPDATE user SET password=PASSWORD("") WHERE user='root' AND host='localhost';
EOF

  if [ "$MYSQL_DATABASE" != "" ]; then
    echo "[i] Creating database: $MYSQL_DATABASE"
    echo "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\` CHARACTER SET utf8 COLLATE utf8_general_ci;" >> $tfile

    if [ "$MYSQL_USER" != "" ]; then
      echo "[i] Creating user: $MYSQL_USER with password $MYSQL_PASSWORD"
      echo "GRANT ALL ON \`$MYSQL_DATABASE\`.* to '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" >> $tfile
    fi
  fi

  /usr/bin/mysqld --user=root --bootstrap --verbose=0 < $tfile
  rm -f $tfile
fi

exec /usr/bin/mysqld --user=root --datadir=/apps/opt/mysql --console

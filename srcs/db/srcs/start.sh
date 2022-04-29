#! /bin/sh

if [ ! -d "/var/lib/mysql/mysql" ]; then
    
    chown -R mysql:mysql /var/lib/mysql
    
    mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm > /dev/null
	
    tfile=`mktemp`
	if [ ! -f "$tfile" ]; then
		return 1
	fi

	cat << EOF > $tfile
USE mysql;
FLUSH PRIVILEGES;
DELETE FROM	mysql.user WHERE User='';
DROP DATABASE test;
DELETE FROM mysql.db WHERE Db='test';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
ALTER USER 'root'@'localhost' IDENTIFIED BY "${MY_SQL_ROOT_PASSWORD}";
CREATE DATABASE IF NOT EXISTS ${MY_SQL_DATABASE} CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER IF NOT EXISTS "${MY_SQL_USER}"@'%' IDENTIFIED by "${MY_SQL_PASSWORD}";
GRANT ALL PRIVILEGES ON ${MY_SQL_DATABASE}.* TO "${MY_SQL_USER}"@'%';
FLUSH PRIVILEGES;
EOF
	/usr/bin/mysqld --user=mysql --bootstrap < $tfile
	rm -f $tfile
fi

exec /usr/bin/mysqld --user=mysql --console
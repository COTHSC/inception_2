cd /srv/wordpress #would be good to change that to env var

if [ ! -f "wp-config.php" ] ; then
	wp core download
fi

connected=0
while [[ $connected -eq 0 ]] ; do
	mariadb -h${MY_SQL_HOST} -u${MY_SQL_USER} -p${MY_SQL_PASSWORD} &> /dev/null
	[[ $? -eq 0 ]] && { connected=$(( $connected + 1 ));}
	sleep 1
done

if [ ! -f "wp-config.php" ] ; then
    wp config create --dbname=wordpress --dbuser=${MY_SQL_USER} --dbpass=${MY_SQL_PASSWORD} --dbhost=${MY_SQL_HOST}:3306
fi

wp core install --url=${MY_WORDPRESS_DOMAIN} --title="jescully" --admin_user=${MY_SQL_USER} --admin_password=${MY_SQL_PASSWORD} --admin_email="jescully@42.fr" --skip-email
wp user create ${WP_USER_NAME} notadmin@42.fr --role=editor --user_pass=${WP_USER_PASSWORD}
php-fpm7 -F
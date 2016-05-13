#!/bin/bash

if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root" 1>&2
    exit 1
fi

# shellinabox
apt-get install apache2 shellinabox
a2enmod ssl
a2enmod proxy
a2enmod proxy_http
mkdir /etc/apache2/ssl
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/apache2/ssl/apache.key -out /etc/apache2/ssl/apache.crt
ip=$(curl myexternalip.com/raw)
sed -i -e "s/1.2.3.4/$ip/g" ./default-ssl.conf
yes | cp -rf ./default-ssl.conf /etc/apache2/sites-available/
a2ensite default-ssl
echo 'SHELLINABOX_ARGS="--localhost-only"' >> /etc/default/shellinabox
service shellinabox restart
service apache2 restart

# google grr for ubuntu 14.04 w/ python 2.7.9+
wget https://raw.githubusercontent.com/google/grr/master/scripts/install_script_ubuntu.sh
bash install_script_ubuntu.sh -dy


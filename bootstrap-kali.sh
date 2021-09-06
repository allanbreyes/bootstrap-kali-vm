#!/usr/bin/env bash
# Bootstrap Kali configuration. All operations *should* be idempotent.

set -e

# Change default user password
user=$(id -nu 1000)
passfile="/root/pass.txt"
if [ -f "$passfile" ]; then
  pass=$(cat $passfile)
else
  pass=$(openssl rand -base64 6)
  touch $passfile
  chmod 400 $passfile
  echo $pass > $passfile
fi
echo -e "$pass\n$pass" | passwd $user 2>/dev/null

# File serves
usermod -aG adm,www-data "$user"
chown -R www-data:www-data /var/www/html /srv/tftp
chmod 775 /var/www/html /srv/tftp
cd /srv && ln -sf /var/www/html && cd -
echo > /srv/html/index.html

# Add custom preferences and scripts
store=/usr/local/bin/store
if [ ! -f "$store" ]; then
  wget -O "$store" https://gist.githubusercontent.com/allanbreyes/f4f301df10476083efc46ecc1cdf7a6c/raw/c88ea3693d035cb7e816b29d390cdfd39cf0cc3b/store.py
  chmod 555 "$store"
fi

# Install packages and updates
pip install tldr
python3 -m pip install git+https://github.com/Tib3rius/AutoRecon.git
DEBIAN_FRONTEND=noninteractive apt-get update -yq && apt-get install -yq \
    zim \
  && apt-get -yq autoremove

# Credentials
echo "login with credentials to $user:$pass"

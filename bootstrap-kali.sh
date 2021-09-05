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

# Add custom preferences and scripts
# store.py
store=/usr/local/bin/store
if [ ! -f "$store" ]; then
  wget -O "$store" https://gist.githubusercontent.com/allanbreyes/f4f301df10476083efc46ecc1cdf7a6c/raw/c88ea3693d035cb7e816b29d390cdfd39cf0cc3b/store.py
  chmod 555 "$store"
fi

# install-mozilla-addon script. Thanks, @eddiejaoude!
install_mozilla_addon=/usr/local/bin/install-mozilla-addon
if [ ! -f "$install_mozilla_addon" ]; then
  wget -O "$install_mozilla_addon" https://gist.githubusercontent.com/eddiejaoude/0076739fe610189581d0/raw/fc13d8bdbaa85ea2bb6f09847a723155c251a9cf/install-mozilla-addon
  chmod 555 "$install_mozilla_addon"
fi

# FoxyProxy
install-mozilla-addon https://addons.mozilla.org/firefox/downloads/file/3616824/foxyproxy_standard-latest.xpi

# Install packages and updates
pip install tldr
DEBIAN_FRONTEND=noninteractive apt-get update -yq && apt-get install -yq \
    zim \
  && apt-get -yq autoremove

# Credentials
echo "login with credentials to $user:$pass"

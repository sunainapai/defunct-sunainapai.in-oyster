#!/bin/sh

# If any command fails, let the script fail.
set -e -x

mkdir -p ~/git
cd ~/git

! [ -d oyster ] &&  git clone https://github.com/sunainapai/oyster.git
! [ -d sunainapai.in ] &&  git clone https://sunainapai@bitbucket.org/sunainapai/sunainapai.in.git

# cd ~/git/oyster
# git pull
# Using oyster at e8ad4b3369413e5cb08c175a0f46e7abd40602a4 commit

cd ~/git/sunainapai.in
git pull
~/git/oyster/oyster

[ -d /var/www/sunainapai.in ] && mv /var/www/sunainapai.in /tmp/sunainapai.in-delete
mv _site /var/www/sunainapai.in
sudo chown -R www-data:www-data /var/www/sunainapai.in
sudo find /var/www/sunainapai.in -type d -exec chmod 770 {} \;
sudo find /var/www/sunainapai.in -type f -exec chmod 660 {} \;
sudo rm -rf /tmp/sunainapai.in-delete

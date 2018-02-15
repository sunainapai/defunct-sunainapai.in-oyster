#!/bin/sh

set -e -x
sudo cp sunainapai.in /etc/nginx/sites-available
sudo ln -s -f /etc/nginx/sites-available/sunainapai.in /etc/nginx/sites-enabled
ls -l /etc/nginx/sites-available
! [ -d /etc/nginx/snippets ] && sudo mkdir /etc/nginx/snippets
sudo cp ~/git/sunainapai.in/nginx/ssl_sunainapai.in.conf /etc/nginx/snippets/ssl_sunainapai.in.conf

sudo service nginx restart
sudo service nginx status
curl http://sunainapai.in/
curl https://sunainapai.in/

#!/usr/bin/env bash
# sets up web servers for deployment of web_static
sudo apt-get update && apt-get install -y nginx
sudo mkdir -p /data/web_static/releases/test /data/web_static/shared
sudo chown ubuntu:ubuntu /data -R
echo "Hello World!" > /data/web_static/releases/test/index.html
ln -fs /data/web_static/releases/test /data/web_static/current
sed -i '/\tlocation \//i\\tlocation \/hbnb_static {\n\t\talias /data/web_static/current;\n\t\tautoindex off;\n\t}'  /etc/nginx/sites-available/default
sudo service nginx restart
exit
#!/usr/bin/env bash
# sets up web servers for deployment of web_static
sudo apt-get update && sudo apt-get install -y nginx
sudo mkdir -p /data/web_static/releases/test /data/web_static/shared
echo -e "<html>\n\t<head>\n\t</head>\n\t<body>\n\t\tHolberton School\n\t</body>\n</html>" > /data/web_static/releases/test/index.html
rm -f /data/web_static/current && ln -s /data/web_static/releases/test /data/web_static/current
sudo chown ubuntu:ubuntu /data -R
sudo grep -q "/hbnb_static"  /etc/nginx/sites-available/default || sudo sed -i '/^\tlocation \//i\\tlocation \/hbnb_static {\n\t\talias /data/web_static/current/;\n\t\tautoindex off;\n\t}'  /etc/nginx/sites-available/default
sudo grep -q "location = /hbnb_static" /etc/nginx/sites-available/default || sudo sed -i '/\tlocation \/hbnb_static /i\\tlocation = /hbnb_static {\n\t\trewrite ^ /hbnb_static/ last;\n\t}' /etc/nginx/sites-available/default
sudo service nginx restart

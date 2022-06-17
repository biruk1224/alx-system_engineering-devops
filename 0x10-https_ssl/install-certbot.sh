#!/usr/bin/env bash
# Documentation: https://certbot.eff.org/lets-encrypt/ubuntuxenial-haproxy.html

sudo snap install core; sudo snap refresh core
sudo apt-get remove certbot, sudo dnf remove certbot, or sudo yum remove certbot

# Stop haproxy before generating the certbot to avoid following error:
#   Problem binding to port 80: Could not bind to IPv4 or IPv6.

sudo service haproxy stop

sudo certbot certonly -d emmastro.tech # Choose option 2

# Location of certificates: /etc/letsencrypt/live/<domain-name>/fullchain.pem
# Location of private keys: /etc/letsencrypt/live/<domain-name>/privkey.pem

# Concatenate the certificate with the private key: this will be used by haproxy
# Go on the folder with your letencrypt keys that you just generated
cd /etc/letsencrypt/live/
# You might want to do be run all these commands as root if you're getting permission denied
sudo bash # run as root

cd <domain-name>
cat cert.pem privkey.pem > all.pem

# Use this all.pem file in your haproxy configuration. Refer to 1-haproxy_ssl_termination file.

# Add the following line on frontend to redirect http to https if needed
http-request redirect scheme https unless { ssl_fc }

# Restart haproxy, and you're good to go!
sudo service haproxy start # or restart

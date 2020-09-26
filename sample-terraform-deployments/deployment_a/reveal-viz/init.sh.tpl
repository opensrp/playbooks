#!/bin/bash

echo "SRE_TOOLING_SERVER_GROUP=\"${group}\"" >> /etc/default/sre-tooling
echo "SRE_TOOLING_REGION=\"${region}\"" >> /etc/default/sre-tooling

# Just in case it was enabled and is running
systemctl stop nginx.service

certbot --standalone certonly -d "${superset_domain}" -m "${app_email}" --agree-tos --noninteractive --text --cert-name "${superset_domain}"
certbot --standalone certonly -d "${reveal_web_domain}" -m "${app_email}" --agree-tos --noninteractive --text --cert-name "${reveal_web_domain}"

# App startup
if [ "${action}" == "initialize" ]; then
  source /home/superset/.virtualenvs/superset/bin/activate
  cd /home/superset/app
  export SUPERSET_CONFIG_PATH=/home/superset/app/superset_config.py
  superset db upgrade
  superset db init
  superset fab create-admin --username "${admin_user}" --firstname admin --lastname user --email "${app_email}" --password "${admin_password}"
fi

unlink /etc/nginx/sites-enabled/default || echo "Already unlinked"
systemctl enable nginx.service
systemctl restart nginx.service
systemctl enable superset.service
systemctl enable celeryd-superset.service
systemctl enable celerybeat-superset.service
systemctl start superset.service
systemctl start celeryd-superset.service
systemctl start celerybeat-superset.service

# Update logstash configuration
sed -i -e 's/git_version => "[a-zA-Z\.0-9 ]*"/git_version => "${superset_version}"\n          deployment => "${deployment}"/' /etc/logstash/conf.d/000_inputs.conf
sudo systemctl restart logstash.service

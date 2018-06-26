echo "$(ps aux | grep /var/lib/couchdb | grep -v grep | awk '{print $2}')"

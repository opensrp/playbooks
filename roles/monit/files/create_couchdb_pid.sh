COUCHDB_PID="$(ps aux | grep /var/lib/couchdb | grep -v grep | awk '{print $2}')"

cat > /var/run/couchdb.pid << EOF
$COUCHDB_PID
EOF

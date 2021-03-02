{{- define "config.initial-scripts.initscript.sh" }}
#!/bin/bash
cat << EOF > initdb.sql
SELECT 'CREATE DATABASE {{ .Values.postgres.database }}'
WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = '{{ .Values.postgres.database }}') \gexec
SELECT
'CREATE USER {{ .Values.postgres.username }} with encrypted password ''{{ .Values.postgres.password }}''' as user_query,
'GRANT ALL PRIVILEGES ON DATABASE {{ .Values.postgres.database }} to {{ .Values.postgres.username }}' as role_query
WHERE NOT EXISTS (SELECT FROM pg_user WHERE usename = '{{ .Values.postgres.usename }}') \gexec;
EOF
export PGPASSWORD={{ .Values.postgres.superuser.password }}
psql -h {{ .Values.postgres.host }} -U {{ .Values.postgres.superuser.name }} -f initdb.sql
{{- end }}
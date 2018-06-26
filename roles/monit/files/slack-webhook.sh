URL="$SLACK_MONIT_WEBHOOK"

PAYLOAD="{
  \"attachments\": [
    {
      \"title\": \"$PROCESS $MONIT_PROCESS_ACTION\",
      \"color\": \"warning\",
      \"mrkdwn_in\": [\"text\"],
      \"fields\": [
        { \"title\": \"Date\", \"value\": \"$MONIT_DATE\", \"short\": true },
        { \"title\": \"Host\", \"value\": \"$MONIT_HOST\", \"short\": true }
      ]
    }
  ]
}"

curl -s -X POST --data-urlencode "payload=$PAYLOAD" $URL

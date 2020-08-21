#!/bin/bash

set -e

# Make sure Monit is stopped
systemctl stop monit

hostname ${hostname}

# wait for the content repo mount to be available
waitSleepSecs=30
maxContentRepoRetries=60
contentRepoNoRetries=0
while [ $contentRepoNoRetries -le $maxContentRepoRetries ] ; do
  if mount | grep "${content_repo_mount_path}" ; then
    echo "${content_repo_mount_path} mounted"
    break
  else
    echo "Waiting for ${content_repo_mount_path} to be mounted"
    sleep $waitSleepSecs
    contentRepoNoRetries=$((contentRepoNoRetries+1))
  fi
done
chmod -R a+rxw "${content_repo_mount_path}"

maxOtherReposRetries=60
otherReposNoRetries=0
while [ $otherReposNoRetries -le $maxOtherReposRetries ] ; do
  if mount | grep "${other_repos_mount_path}" ; then
    echo "${other_repos_mount_path} mounted"
    break
  else
    echo "Waiting for ${other_repos_mount_path} to be mounted"
    sleep $waitSleepSecs
    otherReposNoRetries=$((otherReposNoRetries+1))
  fi
done
chmod -R a+rxw "${other_repos_mount_path}"

systemctl enable collectd
systemctl restart collectd
systemctl enable nifi
systemctl restart nifi

# Wait for domain name to propagate
maxDNSRetries=60
dnsRetries=0
while [ $dnsRetries -le $maxDNSRetries ] ; do
  if nslookup ${domain_name} ; then
    echo "DNS query for ${domain_name} successful"
    break
  else
    echo "Waiting for DNS record for ${domain_name} to propagate"
    sleep $waitSleepSecs
    dnsRetries=$((dnsRetries+1))
  fi
done
certbot --standalone certonly -d ${domain_name} -m ${lets_encrypt_alert_email} --agree-tos --noninteractive --text --cert-name ${domain_name}

systemctl enable monit
systemctl restart monit
monit monitor all
systemctl enable nginx
systemctl restart nginx

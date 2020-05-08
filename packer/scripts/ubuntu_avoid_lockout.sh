#!/usr/bin/env bash

# Avoid package lockout
# Courtesy of David Winterbottom
# Ref: https://codeinthehole.com/tips/avoiding-package-lockout-in-ubuntu-1804/


set -e

function killService() {
    service=$1
    sudo systemctl stop "$service"
    sudo systemctl kill --kill-who=all "$service"
}

function disableTimers() {
    sudo systemctl disable apt-daily.timer
    sudo systemctl disable apt-daily-upgrade.timer
}

function killServices() {
    killService unattended-upgrades.service
    killService apt-daily.service
    killService apt-daily-upgrade.service
}

function main() {
    disableTimers
    killServices
}

main

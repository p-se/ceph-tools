#!/usr/bin/env bash

CEPH_DIR=${CEPH_DIR:-~/src/ceph}

cd "${CEPH_DIR}/build"
../src/stop.sh

# Stop and disable all Ceph related services
for service in $(
    find /etc/systemd/system \
        -regex .\*ceph-.\*@.+.service \
        -exec basename {} \;
); do
    sudo systemctl stop $service
    sudo systemctl disable $service
done

# Delete all Ceph-related services
sudo find /etc/systemd/system \
    -type d \
    -name ceph-\*.target.wants \
    -exec rm -rf {} +

# Reload the systemctl daemon and reset failed services
sudo systemctl daemon-reload
sudo systemctl reset-failed

# Remove Ceph directory
sudo rm -rf /var/lib/ceph

# Stop all podman containers with Ceph in their name
sudo podman ps --format=json |
    jq -r '.[] | "\(.Id) \(.Names)"' |
    grep "${keyword}" |
    awk -F' ' '{print $1}' |
    xargs sudo podman stop

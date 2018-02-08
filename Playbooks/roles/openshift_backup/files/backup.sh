#!/bin/bash

#vars
NOW=$(date +"%Y-%m-%d")
DIR=/opt/backup/$NOW

#Removing logs older then 7 days
find /opt/backup/logs/*.log -mtime +7 | xargs rm
find /opt/backup/tar/*.tar.gz -mtime +7 | xargs rm
find /opt/backup -mtime +7 -type d | xargs rm -rf

for id in `oc get template -n openshift | grep -v NAME | awk '{print $1}'`; do echo $id; oc get template -n openshift $id -o yaml > $DIR/templates/$id.yaml; done

sudo cp -r /etc/origin/master $DIR
sudo cp -r /etc/origin/node $DIR
sudo cp -r /etc/etcd $DIR
sudo cp -r /etc/certs $DIR/certs

sudo cp /etc/sysconfig/atomic* $DIR/sysconfig/
sudo cp /etc/ansible/hosts $DIR
sudo cp /etc/dnsmasq.conf $DIR
sudo cp /etc/sysconfig/docker $DIR
sudo cp /etc/sysconfig/docker-storage-setup $DIR

# ETCD Backup
sudo etcdctl backup --data-dir=/var/lib/etcd --backup-dir=$DIR/etcd_backup
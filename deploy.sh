#!/bin/bash -ex

echo "STARTING DEPLOY..."
echo "DEPLOY TO isucon3"
ssh isucon@118.27.0.147 "source /home/isucon/.bash_profile && cd /home/isucon/torb/webapp/go && git fetch && git checkout ${1:-master} && git pull && make && sudo systemctl restart torb.go"
echo "isucon3 deploy done"

echo ""
echo "DEPLOY TO isucon2"
ssh isucon@118.27.32.125 "source /home/isucon/.bash_profile && cd /home/isucon/torb/webapp/go && git fetch && git checkout ${1:-master} && git pull && make && sudo systemctl restart torb.go && sudo systemctl reload nginx"
ssh isucon@118.27.32.125 ": > /var/log/nginx/access.log"
echo "isucon2 deploy done"

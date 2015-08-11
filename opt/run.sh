#!/bin/sh

export DOCKER_ADDR=${DOCKER_ADDR:-172.17.42.1}
export GATEHOUSE_URL=${GATEHOUSE_URL:-"http://gatehouse:8080"}
export MACHINESHOP_URL=${MACHINESHOP_URL:-"http://machineshop:8080"}

if [[ "$PORTAL_URL" == "" ]]; then
  echo "PORTAL_URL must be defined" 1>&2
  exit 1
fi

cat > /etc/nginx/conf.d/variables.conf <<VARIABLES
set \$portal "$PORTAL_URL";
set \$docker "$DOCKER_ADDR";
set \$gatehouse "$GATEHOUSE_URL";
set \$machineshop "$MACHINESHOP_URL";
VARIABLES

nginx -t

exec /usr/sbin/nginx

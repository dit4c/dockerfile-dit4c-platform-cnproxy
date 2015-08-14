#!/bin/sh


export GATEHOUSE_URL=${GATEHOUSE_URL:-$(echo $GATEHOUSE_PORT | sed -e 's/tcp/http/')}
export MACHINESHOP_URL=${MACHINESHOP_URL:-$(echo $MACHINESHOP_PORT | sed -e 's/tcp/http/')}

if [[ "$PORTAL_URL" == "" ]]; then
  echo "PORTAL_URL must be defined" 1>&2
  exit 1
fi

cat > /etc/nginx/conf.d/variables.conf <<VARIABLES
set \$portal "$PORTAL_URL";
set \$gatehouse "$GATEHOUSE_URL";
set \$machineshop "$MACHINESHOP_URL";
VARIABLES

nginx -t

exec /usr/sbin/nginx

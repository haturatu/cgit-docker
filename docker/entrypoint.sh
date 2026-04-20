#!/bin/sh
set -eu

if [ ! -d /var/lib/git/repos ]; then
    echo "repository path /var/lib/git/repos does not exist" >&2
    exit 1
fi

mkdir -p /run/fcgiwrap
chown www-data:www-data /run/fcgiwrap

if [ -n "${CGIT_TITLE:-}" ]; then
    sed -i "s/^root-title=.*/root-title=${CGIT_TITLE}/" /etc/cgitrc
fi

if [ -n "${CGIT_DESC:-}" ]; then
    sed -i "s/^root-desc=.*/root-desc=${CGIT_DESC}/" /etc/cgitrc
fi

if [ -n "${CGIT_CLONE_BASE_URL:-}" ]; then
    sed -i "s#^clone-url=.*#clone-url=${CGIT_CLONE_BASE_URL}/\\\$CGIT_REPO_URL#" /etc/cgitrc
fi

spawn-fcgi -s /run/fcgiwrap/fcgiwrap.sock -U www-data -G www-data -- /usr/sbin/fcgiwrap

exec nginx -g "daemon off;"

#!/bin/bash
set -ex

echo "Starting"

exec supervisord -c /service/supervisord.conf

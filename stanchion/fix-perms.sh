#!/usr/bin/env bash

rm -rf /tmp/riak
rm -f /var/lib/stanchion/.erlang.cookie
chown -R stanchion:riak /var/log/stanchion
chown -R stanchion:riak /var/lib/stanchion
chmod 755 /var/lib/stanchion
rm -f /var/lib/stanchion/generated.configs/*

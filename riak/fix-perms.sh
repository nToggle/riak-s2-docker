#!/usr/bin/env bash

rm -rf /tmp/riak
rm -f /var/lib/riak/.erlang.cookie
chown -R riak:riak /var/lib/riak
chown -R riak:riak /var/log/riak
chmod 755 /var/lib/riak

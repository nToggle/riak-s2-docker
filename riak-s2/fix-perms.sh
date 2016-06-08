#!/usr/bin/env bash

rm -rf /tmp/riak
chown -R riakcs:riak /var/log/riak-cs
rm -f /var/lib/riak-cs/generated.configs/*

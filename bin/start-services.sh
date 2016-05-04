#!/usr/bin/env bash

rm -rf /tmp/riak
rm /var/lib/riak/.erlang.cookie
chown -R riak:riak /var/lib/riak
chown -R riak:riak /var/log/riak
chown -R riakcs:riak /var/log/riak-cs
chown -R stanchion:riak /var/log/stanchion
chmod 755 /var/lib/riak


echo "Starting riak kv store"
service riak start

if [ "$STANCHION_ENABLED" == "true" ]
then
    echo "Starting stanchion"
    service stanchion start
fi

echo "Starting riak s2"
service riak-cs start

# seed (stanchion node) does not need to join cluster.
if [ "$STANCHION_ENABLED" == "false" ]
then
    echo "Joining cluster at riak@${SEED_HOST}"
    # give it more time to stabilize
    sleep 8
    # Join node to the Riak clusters
    riak-admin cluster join "riak@${SEED_HOST}" || true

    # Are we the last node to join?
    (sleep 8; if riak-admin member-status | egrep "joining|valid" | wc -l | egrep -q "${RIAK_S2_CLUSTER_SIZE}"; then
    riak-admin cluster plan > /dev/null 2>&1 && riak-admin cluster commit > /dev/null 2>&1
    fi) &

fi


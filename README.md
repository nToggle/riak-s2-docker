# RIAK S2 Docker image


This image is intended for cluster deployment of Riak S2 using docker. This uses riak 2.x and new style configuration files.

## build ##

`make build`

## usage ##


The image provides a default configuration that can used to start a container. I will still start a single node riak, stanchion and riak-cs configured locally.

The expected usage, however, is by providing custom configuration files and environment variables to form a cluster.

Env Vars:

- STANCHION_ENABLED: whether to start a stanchion node in the container being started. When disabled, riak will try to join cluster at SEED_HOST. (default: true, assume single node riak)
- SEED_HOST which host to connect in order join the cluster
- RIAK_CLUSTER_SIZE riak clustering needs to know how many nodes are in the cluster before completing the clustering plan. This is used so that last container joining cluster can commit clustering plan.

A sample run command for the seed node is:

```
riak_s2_cluster_size=5
riak_s2_container_version=0.0.1
docker run --net=host --name riak-s2 \
  -v "/local/riak/data:/var/lib/riak:z" \
  -v "/local/riak/logs/riak:/var/log/riak:z" \
  -v "/local/riak/logs/riak-cs:/var/log/riak-cs:z" \
  -v "/local/riak/logs/stanchion:/var/log/stanchion:z" \
  -v "/local/riak/conf/riak.conf:/etc/riak/riak.conf:z" \
  -v "/local/riak/conf/riak-cs.conf:/etc/riak-cs/riak-cs.conf:z" \
  -v "/local/riak/conf/stanchion.conf:/etc/stanchion/stanchion.conf:z" \
    -e "RIAK_S2_CLUSTER_SIZE=$riak_s2_cluster_size" \
  -e "STANCHION_ENABLED=true" \
  quay.io/ntoggle/riak-s2:$riak_s2_container_version
```

And for the non-seed (assuming first container has ip 10.0.1.20):

```
riak_s2_cluster_size=5
riak_s2_container_version=0.0.1
riak_s2_seed=10.0.1.20
docker run --net=host --name riak-s2 \
  -v "/local/riak/data:/var/lib/riak:z" \
  -v "/local/riak/logs/riak:/var/log/riak:z" \
  -v "/local/riak/logs/riak-cs:/var/log/riak-cs:z" \
  -v "/local/riak/logs/stanchion:/var/log/stanchion:z" \
  -v "/local/riak/conf/riak.conf:/etc/riak/riak.conf:z" \
  -v "/local/riak/conf/riak-cs.conf:/etc/riak-cs/riak-cs.conf:z" \
  -v "/local/riak/conf/stanchion.conf:/etc/stanchion/stanchion.conf:z" \
  -e "SEED_HOST={{riak_s2_seed}}" \
  -e "RIAK_S2_CLUSTER_SIZE=$riak_s2_cluster_size" \
  -e "STANCHION_ENABLED=false" \
  quay.io/ntoggle/riak-s2:$riak_s2_container_version
```

First time (on any node of the cluster):

- allow anon creation (anonymous_user_creation on riak-cs.conf)
- restart riak-s2
- create user and copy generated creds
- update admin.key on (riak-cs.conf and stanchion.conf, disable anon creation)
- restart stanchion and riak-s2

```
curl -H 'Content-Type: application/json' -XPOST http://127.0.0.1:8000/riak-cs/user --data '{"email":"admin@ntoggle.com", "name":"admin"}'
```
- set riak_s2_seed on ansible. Run playbook again.


# RIAK S2 Docker image


This image is intended for cluster deployment of Riak S2 using docker. 

## build ##

`make build`

## usage ##

First time:

- allow anon creation (anonymous_user_creation on riak-cs.conf)
- start riak, stanchion and riak-cs
- create user and copy generated creds

```
curl -H 'Content-Type: application/json' -XPOST http://127.0.0.1:8000/riak-cs/user --data '{"email":"admin@ntoggle.com", "name":"admin"}'
```
- set RIAK_ADMIN_KEY and RIAK_ADMIN_SECRET and restart stanchion, riak-cs

.PHONY: riak

build: riak riak-cs stanchion

riak:
	docker build --tag "quay.io/ntoggle/riak:latest" -f Dockerfile-riak .
	docker tag quay.io/ntoggle/riak:latest quay.io/ntoggle/riak:0.0.3
	docker push quay.io/ntoggle/riak:latest

riak-cs:
	docker build --tag "quay.io/ntoggle/riak-s2:latest" -f Dockerfile-riak-s2 .
	docker tag quay.io/ntoggle/riak-s2:latest quay.io/ntoggle/riak-s2:0.0.3
	docker push quay.io/ntoggle/riak-s2:latest

stanchion:
	docker build --tag "quay.io/ntoggle/stanchion:latest" -f Dockerfile-stanchion .
	docker tag quay.io/ntoggle/stanchion:latest quay.io/ntoggle/stanchion:0.0.3
	docker push quay.io/ntoggle/stanchion:latest

run:
	docker rm --force riak | true
	docker rm --force riak-s2 | true
	docker rm --force stanchion | true
	docker run --net=host --privileged -d --name=riak quay.io/ntoggle/riak:0.0.3
	docker run --net=host --privileged -d --name=riak-s2 quay.io/ntoggle/riak-s2:0.0.3
	docker run --net=host --privileged -d --name=stanchion quay.io/ntoggle/stanchion:0.0.3
#	docker run -p 8087:8087 -p 8098:8098 -d --name=riak quay.io/ntoggle/riak:0.0.3
#	docker run -p 8080:8080 -d --name=riak-s2 quay.io/ntoggle/riak-s2:0.0.3
#	docker run -p 8085:8085 -d --name=stanchion quay.io/ntoggle/stanchion:0.0.3

# Getting started with [ualbertalib/swift_dev](https://github.com/ualbertalib/di_docker_swift.git) docker image


This image that implements Swift - highly available, distributed, consistent object store.
This image was created for development purposes to quickly instantiate running instance of swift object store.

## Prerequisites:

  1. [Install Docker](https://docs.docker.com/engine/installation/)


##  Getting swift_dev image

You need to download ualbertalib/swift_dev docker image from docker hub

```shell
docker pull ualbertalib/swift_dev
```

Alternatively you can build swift image locally

  1. Clone current project:
     ```shell
     git clone https://github.com/ualbertalib/di_docker_swift.git
     ```
  2. Go to the directory where you cloned the project
     ```shell
     docker build . -t ualbertalib/swift_dev
     ```

## Maintenance ##

University of Alberta maintains a Docker Hub repository at https://hub.docker.com/r/ualibraries.
Docker image is registered with Docker Hub: [ualbertalib/swift_dev](https://github.com/ualbertalib/di_docker_swift.git)

## Using swift_dev image

Create directory where all swift node files will be stored.
```shell
mkdir ~/.swift
```

Set environment variable to point to that directory

```shell
export LOCAL_SWIFT_STORAGE=~/.swift
```

Run provided shell script
```shell
./runDockerSwift.sh
```

Point your browser [http://127.0.0.1:8080/info](http://127.0.0.1:8080/info)

You should get information in json format about your docker running instance of swift

To shut t down, discover the container name (the last element) with:

```shell
docker ps
```

Then run

```shell
docker stop <container_name>
```


## Swift python client

Install swift python client:
```shell
cd ~
git clone git clone https://github.com/openstack/python-swiftclient.git
cd python-swiftclient
sudo python setup.py develop; cd -
```


Source provided rc file (in DIDockerImages/Swift)
`. ./swiftrc`

Now you can create container
`swd post newCont`

Upload file to the container
`swd upload newCont myfile`

List containers
`swd list`

List files in a container
`swd list newCont`

Display  information about object

`swd stat newCont myfile`

This always works:
`$swd --help`
to get more info


## Using curl to access swift

You can also use curl to access swift
```shell
curl -v -H 'X-Storage-User: test:tester' -H 'X-Storage-Pass: testing' http://127.0.0.1:8080/auth/v1.0
```

will return authorization token you can use with all your future curl command to access swift

Summary of curl commands:
Create a new container

```shell
curl -X PUT -H 'X-Auth-Token: <token-from-above>' http://127.0.0.1:8080/v1/AUTH_test/container2
```

$ist all containers in an account
```shell
curl -X GET -H 'X-Auth-Token: <token-from-above>' http://127.0.0.1:8080/v1/AUTH_test
```

List all the objects in a container
```shell
curl -X GET -H 'X-Auth-Token: <token-from-above>' http://127.0.0.1:8080/v1/AUTH_test/container2
```

Lownload an object
```shell
curl -X GET -H 'X-Auth-Token: <token-from-above>' http://127.0.0.1:8080/v1/AUTH_test/container2/someFile.txt
```


## Versioning

Instructions [here](https://docs.openstack.org/user-guide/cli-swift-set-object-versions.html)


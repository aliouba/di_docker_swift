# Getting started with ualibraries/swift_dev docker image


## Install docker image

You need to download ualibraries/swift_dev docker image from docker hub
(Assuming that you have already have docker installed and running)

```shell
docker pull ualibraries/swift_dev
```

Create directory where all swift node files will be stored.
```shell
mkdir ~/.swift
```

Set environemnt variable to point to that directory

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


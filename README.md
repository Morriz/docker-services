docker-services
======================

A poc I am working on involving orchestration of docker containers.

After having read many sources on the docker dynamics, I have come to a good understanding of the pro's and con's in real world scenario's.

Really working with the software, and configuring a LOT, made me understand the need for automation of the new work at hand: configuration and deployment management...interesting.

I have found my main inspiration here:

* [http://txt.fliglio.com/2013/12/service-discovery-with-docker-docker-links-and-beyond/](http://txt.fliglio.com/2013/12/service-discovery-with-docker-docker-links-and-beyond/)
* [https://github.com/FrozenRidge/dockerfu](https://github.com/FrozenRidge/dockerfu)

### Choices made:
* offer one service per container
* allow ssh access for maintenance and inspection
* implement basic household tasks: forward metrics and logs
* supervisord

### TODO:
* implement hipache
* implement something like dockerfu's mhipache mapping
* implement service discovery (etcd?)
* implement health checking and reloading (like etcdbridge)




FROM centos:latest
MAINTAINER Alex Strilets <strilets@ualberta.ca>

# add out custom repos
ADD files/ualib-centos7.repo /etc/yum.repos.d/ualib-centos7.repo
ADD files/ualib-custom7.repo /etc/yum.repos.d/ualib-custom7.repo
ADD files/ualib-epel7.repo   /etc/yum.repos.d/ualib-epel7.repo
RUN rm /etc/yum.repos.d/CentOS-Base.repo

#add open stack repo
RUN yum install -y centos-release-openstack-newton

#run update
RUN yum -y update

#install required packages
RUN yum install -y curl memcached rsync sqlite xfsprogs supervisor rsyslog

#install swift server packages
RUN yum install -y openstack-swift-account openstack-swift-container \
    openstack-swift-object openstack-swift-proxy

#copy rsync configuration file
ADD files/rsyncd.conf /etc/rsyncd.conf

#rsyslogd dirs and config files for swift
RUN mkdir -p /var/log/swift
RUN chown -R root.adm /var/log/swift
RUN chmod -R g+w /var/log/swift
RUN rm -f /etc/rsyslog.d/openstack-swift.conf
RUN rm -f /etc/rsyslog.conf
ADD files/rsyslog.conf /etc/rsyslog.conf
ADD files/10-swift.conf /etc/rsyslog.d/10-swift.conf

#copy supervisor ini file to start services
ADD files/services.ini /etc/supervisord.d/services.ini

#swift configuration files
RUN rm -rf /etc/swift
ADD files/swift.conf                /etc/swift/swift.conf
ADD files/proxy-server.conf         /etc/swift/proxy-server.conf
ADD files/object-expirer.conf       /etc/swift/object-expirer.conf
ADD files/container-reconciler.conf /etc/swift/container-reconciler.conf
COPY files/account-server   /etc/swift/account-server
COPY files/container-server /etc/swift/container-server
COPY files/object-server    /etc/swift/object-server
RUN mkdir -p /var/cache/swift /var/cache/swift2 /var/cache/swift3 /var/cache/swift4
RUN mkdir -p /var/run/swift


#add startup script
ADD files/initStorage.sh /usr/local/bin/initStorage.sh
ADD files/remakerings /usr/local/bin/remakerings
ADD files/startSwift.sh /usr/local/bin/startSwift.sh

VOLUME /srv
EXPOSE 8080

CMD /usr/local/bin/startSwift.sh

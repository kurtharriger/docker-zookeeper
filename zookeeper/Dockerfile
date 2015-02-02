FROM wouterd/java7

MAINTAINER Wouter Danes <wouter@wouterdanes.net>

ADD zookeeper-3.3.5.tar.gz /
ADD zookeeper-3.4.6.tar.gz /
ADD data.tgz /var/lib/zookeeper

RUN apt-get update 
RUN apt-get install -y net-tools netcat openssh-server

RUN ln -s zookeeper-3.3.5 zookeeper
RUN ln -s /zoo/conf/zoo.cfg zookeeper-3.3.5/conf/zoo.cfg
RUN ln -s /zoo/conf/zoo.cfg zookeeper-3.4.6/conf/zoo.cfg

ADD start-server.sh /

RUN chmod +x /start-server.sh

CMD ["/start-server.sh"]

EXPOSE 22 2888 3888 2181


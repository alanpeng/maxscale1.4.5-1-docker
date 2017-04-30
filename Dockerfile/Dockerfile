FROM centos:7
MAINTAINER Alan Peng <peng.alan@gmail.com>

COPY maxscale.cnf /
COPY start-maxscale.sh /
COPY failover.sh /root/
COPY EmailConfig / 
ADD sendEmail-v1.56.tar.gz /root/

RUN yum -y update
RUN yum -y install perl
RUN yum -y install https://downloads.mariadb.com/MaxScale/1.4.5/centos/7/x86_64/maxscale-1.4.5-1.centos.7.x86_64.rpm
RUN yum -y install http://rancher.wise2c.com/mysql-utilities-1.6.5-1.el7.noarch.rpm
RUN yum -y install http://rancher.wise2c.com/mysql-connector-python-2.1.6-1.el7.x86_64.rpm
RUN yum clean all
RUN rm -rf /tmp/*
RUN chmod +x /root/failover.sh
RUN chmod +x /start-maxscale.sh
RUN mkdir /root/failover
RUN mv /root/sendEmail-v1.56 /root/sendEmail
RUN mkdir -p /etc/maxscale.d
RUN mv /maxscale.cnf /etc/maxscale.d/maxscale.cnf
RUN ln -sf /etc/maxscale.d/maxscale.cnf /etc/maxscale.cnf

# VOLUME for custom configuration
VOLUME ["/etc/maxscale.d"]
VOLUME ["/root/failover"]

# EXPOSE the MaxScale default ports

## RW Split Listener
EXPOSE 4006

## Read Connection Listener
EXPOSE 4008

## Debug Listener
EXPOSE 4442

## CLI Listener
EXPOSE 6603

# Running MaxScale
ENTRYPOINT ["/start-maxscale.sh"]

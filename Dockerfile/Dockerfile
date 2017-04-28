FROM centos:7
MAINTAINER Alan Peng <peng.alan@gmail.com>

COPY maxscale.cnf /
COPY start-maxscale.sh /
COPY failover.sh /root/
COPY EmailConfig / 
ADD sendEmail-v1.56.tar.gz /root/

RUN rpm --import https://yum.mariadb.org/RPM-GPG-KEY-MariaDB \
    && yum -y install https://downloads.mariadb.com/enterprise/yzsw-dthq/generate/10.0/mariadb-enterprise-repository.rpm \
    && yum -y update \
    && yum -y install perl \
    && yum -y install http://172.20.0.1/maxscale-1.4.5-1.centos.7.x86_64.rpm \
    && yum -y install http://172.20.0.1/mysql-connector-python-2.1.5-1.el7.x86_64.rpm \
    && yum -y install http://172.20.0.1/mysql-utilities-1.6.5-1.el7.noarch.rpm \
    && yum clean all \
    && rm -rf /tmp/* \
    && chmod +x /root/failover.sh \
    && mkdir /root/failover \
    && mv /root/sendEmail-v1.56 /root/sendEmail \
    && mkdir -p /etc/maxscale.d \
    && mv /maxscale.cnf /etc/maxscale.d/maxscale.cnf \
    && ln -sf /etc/maxscale.d/maxscale.cnf /etc/maxscale.cnf

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

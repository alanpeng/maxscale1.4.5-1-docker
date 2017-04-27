# maxscale1.4.5-1-docker
```
docker run -itd --name=MaxScale --hostname=maxscale -p 3306:3306 -e MYSQL_ROOT_PASSWORD=password -e REPLICATION_USER=repluser -e REPLICATION_PASSWORD=88888888 -e MasterIP=172.20.10.10 -e Slave1IP=172.20.10.11 -e Slave2IP=172.20.10.12 -e MySQLPort=3307 -e NeverMasterIP=172.20.10.20 -v /root/failover:/root/failover maxscale-docker:1.4.5-1
```

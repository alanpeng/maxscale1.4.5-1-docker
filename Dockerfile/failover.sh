#!/bin/bash
. /root/failover/config
source /root/failover/config

#SendEmailAlertBeforeFailover
/root/sendEmail/sendEmail -f $SenderAddress -t $RecipientsAddress -s $SMTP_Server -u "$SubjectBeforeFailover (Event Time: `date`)" -o message-content-type=$MessageType -o message-charset=$MessageCharset -xu $SenderAccount -xp $SenderPassword -m $MailBodyBeforeFailover -a $AttachmentBeforeFailover

#MySQL Faolover
if [ "$Failover"x = "True"x ]; then

  /usr/bin/mysqlrpladmin --force --slaves=root:$MYSQL_ROOT_PASSWORD@$Slave1IP:$MySQLPort,root:$MYSQL_ROOT_PASSWORD@$Slave2IP:$MySQLPort --candidates=root:$MYSQL_ROOT_PASSWORD@$Slave1IP:$MySQLPort,root:$MYSQL_ROOT_PASSWORD@$Slave2IP:$MySQLPort --rpl-user=$REPLICATION_USER:$REPLICATION_PASSWORD failover

  #SendEmailAlertAfterFailover
  /root/sendEmail/sendEmail -f $SenderAddress -t $RecipientsAddress -s $SMTP_Server -u "$SubjectAfterFailover (Event Time: `date`)" -o message-content-type=$MessageType -o message-charset=$MessageCharset -xu $SenderAccount -xp $SenderPassword -m $MailBodyAfterFailover -a $AttachmentAfterFailover

fi

curl -s -L -o /etc/yum.repos.d/mysql.repo https://raw.githubusercontent.com/roboshop-devops-project/mysql/main/mysql.repo
dnf module disable mysql -y

yum install mysql-community-server -y

systemctl enable mysqld
systemctl restart mysqld

echo show databases | mysql -uroot -p${ROBOSHOP_MYSQL_PASSWORD} &>>$LOG
if [ $? -ne 0 ]
then
  echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '${ROBOSHOP_MYSQL_PASSWORD}';" > /tmp/root-pass-sql
  DEFAULT_PASSWORD=$(grep 'A temporary password' /var/log/mysqld.log | awk '{print $NF}')
  cat /tmp/root-pass-sql  | mysql --connect-expired-password -uroot -p"${DEFAULT_PASSWORD}" &>>$LOG
fi
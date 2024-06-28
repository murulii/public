# Steps

# Installation of Mysql
1) Apply the mysql and mysql service yml file and login to mysql pods and login to mysql database by passing ' mysql -u root -p ' then pass the password root
2) then use this cmd 'use default_db;'
3) then run this command it creates table in database ' CREATE TABLE data ( id INT AUTO_INCREMENT PRIMARY KEY, name TEXT, email TEXT ); '

# Installation of Front End
1) Modify the fronend yml file and Run fronend and svc and access using NodePort

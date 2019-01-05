#!\bin\bash

# cassandra db install ***run as root***

# update server packages
yum -y update

# install the latest version of Oracle Java into the server
# run the following command to download the RPM package.
# ***If you do not have wget installed, you can run the yum -y install wget to install wget***
wget --no-cookies --no-check-certificate --header "Cookie:oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.rpm"

# install the downloaded RPM
yum -y localinstall jdk-8u131-linux-x64.rpm

# check the Java version
java --version

# check if JAVA_HOME environment variable is set
echo $JAVA_HOME

# If you get a null or blank output, manually set the JAVA_HOME variable
#vim ~/.bash_profile

# add the following lines at the at the end of the file
#export JAVA_HOME=/usr/java/jdk1.8.0_131/
#export JRE_HOME=/usr/java/jdk1.8.0_131/jre

# Now source the file using the following command.
#source ~/.bash_profile

# run the echo $JAVA_HOME command again to check if the environment variable is set
# [root@centos-7 ~]# echo $JAVA_HOME
# command output --> /usr/java/jdk1.8.0_131/

# add the cassandra repo

touch /etc/yum.repos.d/cassandra.repo
echo "[cassandra]
name=Apache Cassandra
baseurl=https://www.apache.org/dist/cassandra/redhat/311x/
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://www.apache.org/dist/cassandra/KEYS" >>/etc/yum.repos.d/cassandra.repo

# install Cassandra
yum -y install cassandra

# reload system daemons
systemctl daemon-reload

# start cassandra and enable start on boot
systemctl start cassandra
systemctl enable cassandra

# verify cassandra is running
nodetool status

# output should look similar to the following:
#[root@ip-172-31-7-136 ~]# nodetool status
#Datacenter: datacenter1
#=======================
#Status=Up/Down
#|/ State=Normal/Leaving/Joining/Moving
#--  Address    Load       Tokens       Owns (effective)  Host ID                               Rack
#UN  127.0.0.1  136.29 KiB  256          100.0%            b3d26649-9e10-4bee-9b3c-8e81c4394b2e  rack1

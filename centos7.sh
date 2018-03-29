#!/bin/bash
#NEED ROOT 


#CONSANT
MYSQL_PASSWD="zhoujl.123"

#in office env
function setProxy(){
	export http_proxy=http://***:***@192.168.13.19:7777
	export https_proxy=http://***:***@192.168.13.19:7777
}

#default EPEL 
function updateYum(){
	sudo yum install -y epel-release 
	if [ ! $? eq 0 ] ;  then 
		wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
		sudo rpm -Uvh epel-release-latest-7*.rpm
	fi;
	sudo yum -y update
	sudo yum groupinstall "Development tools"
}

##
function updateGit(){
	sudo yum update git
}

#git version 2.0
function installGitFromSrc(){

	yum install -y curl-devel expat-devel gettext-devel openssl-devel zlib-devel
	yum install -y gcc perl-ExtUtils-MakeMaker
	yum remove git
	
	cd /opt
	wget https://www.kernel.org/pub/software/scm/git/git-2.0.4.tar.gz
	tar xzf git-2.0.4.tar.gz
	cd git-2.0.4
    make prefix=/usr/local/git all
    make prefix=/usr/local/git install

    echo 'export PATH=$PATH:/usr/local/git/bin' >> /etc/bashrc
    source /etc/bashrc
}

function installLrzsz(){
	sudo yum install -y lrzsz
}


function installMysql(){
	cd /opt
	wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
	rpm -ivh mysql-community-release-el7-5.noarch.rpm  
	sudo yum install -y mysql-server  
}

function instatllJDK(){
	cd /opt
	wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.rpm  
	##删除原本的jdk
	rpm -qa|grep ^java-1|xargs rpm -e 
	rpm -ivh jdk-8u131-linux-x64.rpm
}

function installGolang(){
	sudo yum install -y golang
}

function configureGit(){
	git config --global user.name zhoujinl
	git config --global user.email zhoujinl@126.com
}

#只能执行一次
function startMysql(){
	sudo service mysqld start
	mysqladmin -u root password $MYSQL_PASSWD
}


#Before
cd /opt
setProxy

#First update yum repository
updateYum

#Second install pupular package: git,lrzsz
installGitFromSrc
installLrzsz
installMysql
instatllJDK
installGolang

#Third  configure 
configureGit

#Fourth run process
startMysql


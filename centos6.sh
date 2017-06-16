#!/bin/bash

#NEED ROOT 

#default EPEL 
function updateYum(){
	sudo yum install -y epel-release 
	if [ ! $? eq 0 ] ;then 
		wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
		sudo rpm -Uvh epel-release-6*.rpm
	fi;
	sudo yum clean all
	#sudo yum groupinstall "Development Tools"
}

function updateGit(){
	sudo yum update git
}

function installGitFromSrc()(

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
)

function installLrzsz(){
	sudo yum install -y lrzsz
}


function configureGit(){

	git config --global user.name zhoujinl
	git config --global user.email zhoujinl@126.com
}

#in office env
function setProxy(){
	export http_proxy=http://guozhw:ffcs1234@192.168.13.19:7777
	export https_proxy=http://guozhw:ffcs1234@192.168.13.19:7777
}

#Before
cd /opt


#First update yum repository
updateYum

#Second install pupular package: git,lrzsz
installGitFromSrc
installLrzsz

#Third  configure 
configureGit


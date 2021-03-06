#!/bin/bash


echo "Please select you want to install the Tomcat version?"
select tomcat_version in "Tomcat7x" "Tomcat8x" ; do
  break;
done

tomcatpath=/usr/local/webserver/
# 不存在
if [ ! -d "$tomcatpath" ]; then
    echo "正在创建$tomcatpath目录"
    sudo mkdir $tomcatpath
    echo "目录$tomcatpath创建成功"
fi

tomcatfile=$(ls | grep apache-tomcat-*.gz)

tomcatname=""

if [ "$tomcat_version" = "Tomcat7x" ]; then
    tomcatname="tomcat7"
else
    tomcatname="tomcat8"
fi

# 不存在即去外网下载jdk文件
if [ ! -f "$tomcatfile" ]; then
    if [ "$tomcat_version" = "Tomcat7x" ]; then
        wget http://apache.cs.utah.edu/tomcat/tomcat-7/v7.0.63/bin/apache-tomcat-7.0.63.tar.gz
    else
        wget http://mirror.tcpdiag.net/apache/tomcat/tomcat-8/v8.0.23/bin/apache-tomcat-8.0.23.tar.gz
    fi
fi

tomcatfile=$(ls | grep apache-tomcat-*.gz)

if [ -f "$tomcatfile" ]; then

    sudo tar -zxvf $tomcatfile -C $tomcatpath

    sudo mv $tomcatpath$tomcatfile $tomcatname

    echo "安装Tomcat成功"

    echo "配置环境变量"

    mv ~/.bashrc ~/.bashrc.backup.tomcat
    cat ~/.bashrc.backup.tomcat >> ~/.bashrc

    #echo "PATH=\"$PATH:$tomcatpath$tomcatname\"" >> ~/.bashrc
    echo "TOMCAT_HOME=$tomcatpath$tomcatname" >> ~/.bashrc
    echo "CATALINA_HOME=$tomcatpath$tomcatname" >> ~/.bashrc
    echo "export PATH=\"$PATH:$tomcatpath$tomcatname\"" >> ~/.bashrc

    source ~/.bashrc

    echo "配置环境成功"

    echo "安装成功"

fi

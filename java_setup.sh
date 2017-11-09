#!/bin/bash
#Installation and configuration Java
mkdir /opt/java
wget --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" -qO - http://download.oracle.com/otn-pub/java/jdk/8u151-b12/e758a0de34e24606bca991d704f6dcbf/jdk-8u151-linux-x64.tar.gz | tar -C /opt/java -xzf -
alternatives --install /usr/bin/java java /opt/java/jdk1.8.0_151/bin/java 1
alternatives --install /usr/bin/javac javac /opt/java/jdk1.8.0_151/bin/javac 1

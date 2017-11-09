#!/bin/bash

JENKINS_DIR=/opt/jenkins/bin
JENKINS_LOG=/opt/jenkins/bin/jenkins.log

nohup java -jar $JENKINS_DIR/jenkins.war > $JENKINS_LOG 2>&1 &

#!/bin/bash

defaultBuildId=spring-petclinic-2.1.0.BUILD-SNAPSHOT.jar
buildId=${1:-$defaultBuildId}

echo "update outdates packages and wait 30 seconds";
sudo apt-get update
sleep 30s

echo "install java and wait 30 seconds";
sudo apt install -y openjdk-11-jre-headless
sleep 30s

echo "Verifying java was installed";
java --version

# Install software application
echo "Installing software application form /tmp"
cd /tmp
pwd
ls -l
echo "This is the COPY COMMAND:";
echo "cp \"$buildId\" /var/lib/tomcat9/webapps/"
cp $buildId /home/ubuntu
echo "Change ownership so it can be started by the process"
sudo chown ubuntu:ubuntu spring-petclinic-2.1.0.BUILD-SNAPSHOT.jar

echo "installing petclinic services to run petclinic as service so it starts automatically"
sudo cp petclinic.sh /usr/local/bin/
sudo chmod +x /usr/local/bin/petclinic.sh

sudo cp petclinic.service /etc/systemd/system/
sudo chmod 644 /etc/systemd/system/petclinic.service

sudo systemctl daemon-reload
sudo systemctl enable petclinic

# Now, the service can be managed with these commands
#sudo systemctl daemon-reload
#sudo systemctl enable petclinic
#sudo systemctl start petclinic
#sudo systemctl stop petclinic
#sudo systemctl status petclinic

sleep 30s
echo "Done deploying application";

#!/bin/bash

echo "Creating directories..."

sudo mkdir -p /opt/geneos/binaries/agent
sudo mkdir -p /opt/geneos/binaries/euem-netprobe
sudo mkdir -p /opt/geneos/binaries/fix-analyser2
sudo mkdir -p /opt/geneos/binaries/gateway
sudo mkdir -p /opt/geneos/binaries/licd
sudo mkdir -p /opt/geneos/binaries/netprobe
sudo mkdir -p /opt/geneos/binaries/webdashboard/jre
sudo mkdir -p /opt/geneos/binaries/webdashboard/nojre

sudo mkdir -p /opt/lib/database/oracle
sudo mkdir -p /opt/lib/database/mysql
sudo mkdir -p /opt/lib/database/mssql
sudo mkdir -p /opt/lib/database/postgresql
sudo mkdir -p /opt/lib/database/sybase
sudo mkdir -p /opt/lib/java/oracle
sudo mkdir -p /opt/lib/mqm

sleep 2

echo "Creating soft links..."

cd /opt/geneos/binaries
ln -sf /home/sandbox/scripts/unpacker_auto_prod.bash unpacker_auto_prod.bash
ln -sf /home/sandbox/scripts/unpacker_prod.bash unpacker_prod.bash
ln -sf /home/sandbox/scripts/unpacker.bash unpacker.bash

sleep 2

echo "Configuring permissions..."

cd /home/sandbox/scripts
chmod 664 .*.txt
chmod 755 *.bash
sudo chown sandbox:domain^users -R .port

cd /opt
sudo chown sandbox:domain^users -R geneos
sudo chown sandbox:domain^users -R jmx
sudo chown sandbox:domain^users -R lib
sudo chown sandbox:domain^users -R mqm

sleep 2

echo "Done."

exit


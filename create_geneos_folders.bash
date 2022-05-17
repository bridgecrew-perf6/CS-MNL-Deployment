#!/bin/bash

# Directories

GENEOS_BIN_DIR=/opt/geneos/binaries
SANDBOX_HOME=/home/sandbox

# ACTUAL LOGIC

# Create directories

# For sandbox user

cd ${SANDBOX_HOME}

mkdir -p geneos_release/old
mkdir -p geneos_release/current
#mkdir scripts

cd ${SANDBOX_HOME}/scripts

chmod 664 .*.txt
chmod 755 *.bash
chmod -R 777 .port

chown sandbox:domain^users -R .port

# For Geneos

mkdir -p ${GENEOS_BIN_DIR}

echo "Creating directories"
echo ""

cd ${GENEOS_BIN_DIR}

mkdir file-agent
mkdir fix-analyser2
mkdir gateway
mkdir licd
mkdir netprobe
mkdir sso
mkdir web-server
mkdir webslinger

echo "Changing owner"
echo ""

chown -R sandbox:sandbox file-agent
chown -R sandbox:sandbox fix-analyser2
chown -R sandbox:sandbox gateway
chown -R sandbox:sandbox licd
chown -R sandbox:sandbox netprobe
chown -R sandbox:sandbox sso
chown -R sandbox:sandbox web-server
chown -R sandbox:sandbox webslinger

echo "Changing permissions"
echo ""

chmod -R 777 file-agent
chmod -R 777 fix-analyser2
chmod -R 777 gateway
chmod -R 777 licd
chmod -R 777 netprobe
chmod -R 777 sso
chmod -R 777 web-server
chmod -R 777 webslinger

exit

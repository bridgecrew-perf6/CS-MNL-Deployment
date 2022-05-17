#!/bin/bash

# DESCRIPTION
#
# Restarts sandbox's Netprobes on target servers.

# ACTUAL LOGIC

# Directories
GENEOS_SERVER_LIST=/home/sandbox/scripts/geneos_gateway.txt
USER=sandbox

# Check if the list contains the names of the target servers.
COUNT_FOR=`cat ${GENEOS_SERVER_LIST} | wc -l`
TARGET_FOLDER=${GENEOS_BIN_DIR}
if [ ${COUNT_FOR} -ne 0 ]; then
	echo "Found ${COUNT_FOR} Geneos servers."
else
	echo "No Geneos servers in ${GENEOS_SERVER_LIST}. Check the file and retry."
	echo ""
	echo "----- END -----"
	exit
fi

# For-loop: Get the target server name and tranfer the files.
RESTART_GATEWAY=`/home/sandbox/start_gateway_6699.bash restart`
RESTART_NETPROBE="/home/sandbox/start_netprobe_6699.bash"
for (( c=1; c<=${COUNT_FOR}; c++ ))
do
	TARGET_SERVER=`head -"${c}" ${GENEOS_SERVER_LIST} | tail -1`
	echo ""
	echo "Restarting the sandbox Netprobe in ${TARGET_SERVER}"
	ssh ${USER}@${TARGET_SERVER} ${RESTART_NETPROBE}
done

exit

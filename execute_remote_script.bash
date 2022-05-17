#!/bin/bash

# DESCRIPTION
#
# Executes scripts on located on a target server.

# ACTUAL LOGIC

# Directories

GENEOS_SERVER_LIST=/home/sandbox/scripts/geneos_servers.txt
USER=sandbox

echo ""
echo "----- START execute_remote_script.bash -----"

# Check if $1 has a value.

if [[ ${1} != "" ]]; then

	# Check if the list contains the names of the target servers.

	COUNT_FOR=`cat ${GENEOS_SERVER_LIST} | wc -l`
	if [ ${COUNT_FOR} -ne 0 ]; then
			echo "Found ${COUNT_FOR} Geneos servers."
	else
			echo "No Geneos servers in ${GENEOS_SERVER_LIST}. Check the file and retry."
			echo ""
			echo "----- END -----"
			exit
	fi

	# For-loop: Get the target server name and tranfer the files.
	REMOTE_SCRIPT=/home/sandbox/scripts/${1}
	for (( c=1; c<=${COUNT_FOR}; c++ ))
	do

			TARGET_SERVER=`head -"${c}" ${GENEOS_SERVER_LIST} | tail -1`
			echo ""
			echo "Executing ${REMOTE_SCRIPT} in ${TARGET_SERVER}"
			ssh ${USER}@${TARGET_SERVER} ${REMOTE_SCRIPT}
	done

else

	echo ""
	echo "Usage is: ./execute_remote_script.bash <script name>."
	echo "e.g"
	echo "./execute_remote_script.bash create_geneos_folders.bash."

fi

echo ""
echo "----- END execute_remote_script.bash -----"
echo ""

exit

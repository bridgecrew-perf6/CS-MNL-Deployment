#!/bin/bash

# DESCRIPTION
#
# Executes the unpacker_auto.bash script on a target server.

# FUNCTIONS

execute_unpacker_remote() {
	
	# Check if the list contains the names of the target servers. 
	
	COUNT_FOR=`cat ${GENEOS_SERVER_LIST} | wc -l`
	TARGET_FOLDER=${GENEOS_BIN_DIR}
	if [ ${COUNT_FOR} -ne 0 ]; then
		echo "Found ${COUNT_FOR} Geneos servers."
	else
		echo "No Geneos servers in ${GENEOS_SERVER_LIST}. Check the file and retry."
		echo ""
		echo "Exiting script"
		exit
	fi
	
	# For-loop: Get the target server name and tranfer the files.
	
	for (( c=1; c<=${COUNT_FOR}; c++ ))
	do  
		
		TARGET_SERVER=`head -"${c}" ${GENEOS_SERVER_LIST} | tail -1`
		echo ""
		echo "Executing unpacker_auto.bash in ${TARGET_SERVER}"
		ssh ${USER}@${TARGET_SERVER} ${UNPACKER_SCRIPT}
	done
}

# ACTUAL LOGIC

# Directories

GENEOS_BIN_DIR=/opt/geneos/binaries
GENEOS_SERVER_LIST=/home/sandbox/scripts/geneos_servers.txt
UNPACKER_SCRIPT=/home/sandbox/scripts/unpacker_auto.bash
USER=sandbox

# Ask user to proceed.
echo ""
echo "START"
echo "The script will ask you to enter the password on numerous occasions depending on the number of target servers. Do you want to proceed?"
echo ""
echo "YES or NO? (Input the answer in all caps):"
read ANSWER
if [ ${ANSWER} = "YES" ]; then
	execute_unpacker_remote
elif [ ${ANSWER} = "NO" ]; then
	echo "Run the script again when you are ready."
else
	echo "You did not follow the instructions. Run the script again."
fi

#echo "Deleting files in ${GENEOS_TEMP_RELEASE_DIR}."
#rm ${GENEOS_TEMP_RELEASE_DIR}/*
#echo "Files deleted."	

echo ""
echo "END"

exit

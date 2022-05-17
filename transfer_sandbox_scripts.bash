#!/bin/bash

# DESCRIPTION
#
# Transfers all files except the .port folder found in /home/sandbox/scripts to the target Geneos servers.

# FUNCTIONS

transfer_scripts() {
	
	# Check if the list contains the names of the target servers. 
	
	COUNT_FOR=`cat ${GENEOS_SERVER_LIST} | wc -l`
	TARGET_FOLDER=${SANDBOX_SCRIPTS}
	if [ ${COUNT_FOR} -ne 0 ]; then
		echo "Found ${COUNT_FOR} Geneos servers."
	else
		echo "No Geneos servers in ${GENEOS_SERVER_LIST}. Check the file and retry."
		echo "Exiting script."
		exit
	fi
	
	# For-loop: Get the target server name and tranfer the files.
	
	for (( c=1; c<=${COUNT_FOR}; c++ ))
	do  
		
		TARGET_SERVER=`head -"${c}" ${GENEOS_SERVER_LIST} | tail -1`
		echo ""
		echo "Transferring files to ${TARGET_SERVER} ${TARGET_FOLDER}"
		#scp *.bash *.txt *.conf .*.txt ${USER}@${TARGET_SERVER}:${TARGET_FOLDER}
		scp *.bash *.txt .*.txt *.reference .*.reference *.gz .*.xml ${USER}@${TARGET_SERVER}:${TARGET_FOLDER}
	done
}

# ACTUAL LOGIC

# Directories

SANDBOX_SCRIPTS=/home/sandbox/scripts
GENEOS_SERVER_LIST=${SANDBOX_SCRIPTS}/geneos_servers.txt
USER=sandbox

# Ask user to proceed.
echo ""
echo "START"
echo "The script will ask you to enter the password on numerous occasions depending on the number of target servers. Do you want to proceed?"
echo ""
echo "YES or NO? (Input the answer in all caps):"
read ANSWER
if [ ${ANSWER} = "YES" ]; then
	transfer_scripts
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

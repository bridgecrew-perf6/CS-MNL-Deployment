#!/bin/bash

# DESCRIPTION
#
# Transfers the Geneos binaries to a target server and to its respective folders.

# FUNCTIONS

transfer_binary() {
	
	# Check if the list contains the names of the target servers. 
	
	COUNT_FOR=`cat ${GENEOS_SERVER_LIST} | wc -l`
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
		scp * ${USER}@${TARGET_SERVER}:${TARGET_FOLDER}
	done
}

check_binary() {
	
	# Check if binaries exist and transfer them.
	cd ${GENEOS_CURRENT_RELEASE_DIR}
	echo ""
	echo "Working on the binaries in ${GENEOS_CURRENT_RELEASE_DIR}"
	COUNT_TARGZ=`ls *.tar.gz | wc -l`
	COUNT_SSO_AGENT=`ls sso-agent* | wc -l`
	TARGET_FOLDER=${GENEOS_CURRENT_RELEASE_DIR}
	SUM=$((${COUNT_TARGZ} + ${COUNT_SSO_AGENT}))
		if [ ${SUM} -ne 0 ]; then
			echo "Found ${SUM} current Geneos binaries."
			transfer_binary
		else
			echo "No Geneos binaries in ${GENEOS_CURRENT_RELEASE_DIR}."
		fi
	
	cd ${GENEOS_OLD_RELEASE_DIR}
	echo ""
	echo "Working on the binaries in ${GENEOS_OLD_RELEASE_DIR}"
	COUNT_TARGZ=`ls *.tar.gz | wc -l`
	COUNT_SSO_AGENT=`ls sso-agent* | wc -l`
	TARGET_FOLDER=${GENEOS_OLD_RELEASE_DIR}
	SUM=$((${COUNT_TARGZ} + ${COUNT_SSO_AGENT}))
		if [ ${SUM} -ne 0 ]; then
			echo "Found ${SUM} old Geneos binaries."
			transfer_binary
		else
			echo "No Geneos binaries in ${GENEOS_OLD_RELEASE_DIR}."
		fi
}

# ACTUAL LOGIC

# Directories

GENEOS_BIN_DIR=/opt/geneos/binaries
GENEOS_CURRENT_RELEASE_DIR=/home/sandbox/geneos_release/current
GENEOS_OLD_RELEASE_DIR=/home/sandbox/geneos_release/old
GENEOS_SERVER_LIST=/home/sandbox/scripts/geneos_servers.txt
USER=sandbox

# Ask user to proceed.
echo ""
echo "START"
echo "The script will ask you to enter the password on numerous occasions depending on the number of target servers. Are the binaries in the correct folders?"
echo "i.e."
echo "- current releases = ${GENEOS_CURRENT_RELEASE_DIR}"
echo "- not current releases = ${GENEOS_OLD_RELEASE_DIR}"
echo ""
echo "YES or NO? (Input the answer in all caps):"
read ANSWER
if [ ${ANSWER} = "YES" ]; then
	check_binary
elif [ ${ANSWER} = "NO" ]; then
	echo "Run the script again when you are ready."
else
	echo "You did not follow the instructions. Run the script again."
fi

echo ""
echo "END"
exit

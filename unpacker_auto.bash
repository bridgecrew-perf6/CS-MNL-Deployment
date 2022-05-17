#!/bin/bash

# DESCRIPTION
# Moves and unpacks the Geneos Gateway, File Agent, FIX Analyser2, LICD and Netprobe *.tar.gz binaries to their respective folders in /opt/geneos/binaries.
# Moves the Geneos SSO Agent, WebServer/Web Dashboard and Webslinger binaries to their respective folders in /opt/geneos/binaries.

# FUNCTIONS
unpack_fileagent() {
	echo "Moving and unpacking ${FILENAME}."
	cp ${FILENAME} ${GENEOS_BIN_DIR}/file-agent
	cd ${GENEOS_BIN_DIR}/file-agent
	VERSION=`echo ${FILENAME} | awk -F "-" '{print $2"-"$3"-"$4}'`
	${GENEOS_UNPACKER_SCRIPT} ${VERSION}
	echo "Done with ${FILENAME}."
}

unpack_fixanalyser2() {
	echo "Moving and unpacking ${FILENAME}."
	cp ${FILENAME} ${GENEOS_BIN_DIR}/fix-analyser2
	cd ${GENEOS_BIN_DIR}/fix-analyser2
	VERSION=`echo ${FILENAME} | awk -F "-" '{print $2"-"$3"-"$4}'`
	${GENEOS_UNPACKER_SCRIPT} ${VERSION}
	echo "Done with ${FILENAME}."
}

unpack_gateway() {
	echo "Moving and unpacking ${FILENAME}."
	cp ${FILENAME} ${GENEOS_BIN_DIR}/gateway
	cd ${GENEOS_BIN_DIR}/gateway
	VERSION=`echo ${FILENAME} | awk -F "-" '{print $2"-"$3}'`
	${GENEOS_UNPACKER_SCRIPT} ${VERSION}
	echo "Done with ${FILENAME}."
}

unpack_licd() {
	echo "Moving and unpacking ${FILENAME}."
	cp ${FILENAME} ${GENEOS_BIN_DIR}/licd
	cd ${GENEOS_BIN_DIR}/licd
	VERSION=`echo ${FILENAME} | awk -F "-" '{print $2"-"$3}'`
	${GENEOS_UNPACKER_SCRIPT} ${VERSION}
	echo "Done with ${FILENAME}."
}

unpack_netprobe() {
	echo "Moving and unpacking ${FILENAME}."
	cp ${FILENAME} ${GENEOS_BIN_DIR}/netprobe
	cd ${GENEOS_BIN_DIR}/netprobe
	VERSION=`echo ${FILENAME} | awk -F "-" '{print $2"-"$3}'`
	${GENEOS_UNPACKER_SCRIPT} ${VERSION}
	echo "Done with ${FILENAME}."
}

move_webserver() {
	echo "Moving ${FILENAME}."
	cp ${FILENAME} ${GENEOS_BIN_DIR}/web-server
	echo "Done with ${FILENAME}."
}

move_webslinger() {
	echo "Moving ${FILENAME}."
	cp ${FILENAME} ${GENEOS_BIN_DIR}/webslinger
	echo "Done with ${FILENAME}."
}

move_ssoagent() {
	echo "Moving ${FILENAME}."
	cp ${FILENAME} ${GENEOS_BIN_DIR}/sso
	echo "Done with ${FILENAME}."
}

unpack_generic() {
	echo "Filename is ${FILENAME}"
}

unpack_binary() {

	# Check if binaries exist in the current folder before unpacking them.
	
	cd ${GENEOS_CURRENT_RELEASE_DIR}
	echo ""
	echo "Working on the binaries in ${GENEOS_CURRENT_RELEASE_DIR}"
	COUNT_TARGZ=`ls *.tar.gz | wc -l`
	COUNT_SSO_AGENT=`ls sso-agent* | wc -l`
	TARGET_FOLDER=${GENEOS_CURRENT_RELEASE_DIR}
	GENEOS_UNPACKER_SCRIPT=${SANBOX_HOME_DIR}/scripts/unpacker_current_release.bash
	SUM=$((${COUNT_TARGZ} + ${COUNT_SSO_AGENT}))
		if [ ${SUM} -ne 0 ]; then
			echo "Found ${SUM} current Geneos binaries."
			
			# Unpack the binaries
			
			for (( c=1; c<=${SUM}; c++ ))
			do  
				cd ${TARGET_FOLDER}
				FILENAME=`ls | head -"${c}" | tail -1`
				echo ${c}
				if [[ ${FILENAME} == geneos-file-agent* ]]; then
					unpack_fileagent
				elif [[ ${FILENAME} == geneos-fixanalyser2-netprobe* ]]; then
					unpack_fixanalyser2
				elif [[ ${FILENAME} ==  geneos-gateway* ]]; then
					unpack_gateway
				elif [[ ${FILENAME} == geneos-licd* ]]; then
					unpack_licd
				elif [[ ${FILENAME} == geneos-netprobe* ]]; then
					unpack_netprobe
				elif [[ ${FILENAME} == geneos-web-server* ]]; then
					move_webserver
				elif [[ ${FILENAME} == geneos-webslinger* ]]; then
					move_webslinger
				elif [[ ${FILENAME} == sso-agent* ]]; then
					move_ssoagent
				else
					unpack_generic
				fi
			done
		else
			echo "No Geneos binaries in ${GENEOS_CURRENT_RELEASE_DIR}."
		fi
		
	# Check if binaries exist in the old folder before unpacking them.
	
	cd ${GENEOS_OLD_RELEASE_DIR}
	echo ""
	echo "Working on the binaries in ${GENEOS_OLD_RELEASE_DIR}"
	COUNT_TARGZ=`ls *.tar.gz | wc -l`
	COUNT_SSO_AGENT=`ls sso-agent* | wc -l`
	TARGET_FOLDER=${GENEOS_OLD_RELEASE_DIR}
	GENEOS_UNPACKER_SCRIPT=${SANBOX_HOME_DIR}/scripts/unpacker_old_release.bash
	SUM=$((${COUNT_TARGZ} + ${COUNT_SSO_AGENT}))
		if [ ${SUM} -ne 0 ]; then
			echo "Found ${SUM} old Geneos binaries."
			
			# Unpack the binaries
			
			for (( c=1; c<=${SUM}; c++ ))
			do  
				cd ${TARGET_FOLDER}
				FILENAME=`ls | head -"${c}" | tail -1`
				echo ${c}
				if [[ ${FILENAME} == geneos-file-agent* ]]; then
					unpack_fileagent
				elif [[ ${FILENAME} == geneos-fixanalyser2-netprobe* ]]; then
					unpack_fixanalyser2
				elif [[ ${FILENAME} ==  geneos-gateway* ]]; then
					unpack_gateway
				elif [[ ${FILENAME} == geneos-licd* ]]; then
					unpack_licd
				elif [[ ${FILENAME} == geneos-netprobe* ]]; then
					unpack_netprobe
				elif [[ ${FILENAME} == geneos-web-server* ]]; then
					move_webserver
				elif [[ ${FILENAME} == geneos-webslinger* ]]; then
					move_webslinger
				elif [[ ${FILENAME} == sso-agent* ]]; then
					move_ssoagent
				else
					unpack_generic
				fi
			done
		else
			echo "No Geneos binaries in ${GENEOS_CURRENT_RELEASE_DIR}."
		fi
}

# ACTUAL LOGIC

# Directories

SANBOX_HOME_DIR=/home/sandbox
GENEOS_BIN_DIR=/opt/geneos/binaries
GENEOS_CURRENT_RELEASE_DIR=${SANBOX_HOME_DIR}/geneos_release/current
GENEOS_OLD_RELEASE_DIR=${SANBOX_HOME_DIR}/geneos_release/old
GENEOS_SERVER_LIST=${SANBOX_HOME_DIR}/scripts/geneos_servers.txt

# Ask user to proceed.
echo ""
echo "START"
echo "Are the binaries in the correct folders?"
echo "i.e."
echo "- current releases = ${GENEOS_CURRENT_RELEASE_DIR}"
echo "- not current releases = ${GENEOS_OLD_RELEASE_DIR}"
echo ""
echo "YES or NO? (Input the answer in all caps):"
read ANSWER
if [ ${ANSWER} = "YES" ]; then
	unpack_binary
elif [ ${ANSWER} = "NO" ]; then
	echo "Exiting the script."
else
	echo "You did not follow the instructions. Run the script again."
fi

# CLEAN UP

# Delete the files in the current and old folders

echo "Deleting files in ${GENEOS_CURRENT_RELEASE_DIR} and ${GENEOS_OLD_RELEASE_DIR}."
rm ${GENEOS_CURRENT_RELEASE_DIR}/* ${GENEOS_OLD_RELEASE_DIR}/*
echo "Files deleted."	

# FOR DEBUG

# List the contents of the Geneos folders
#echo ""
#echo "----- DEBUG -----"
#cd ${GENEOS_BIN_DIR}
#ls file-agent/* fix-analyser2/* gateway/* licd/* netprobe/* sso/* web-server/* webslinger/*

echo ""
echo "END"
exit

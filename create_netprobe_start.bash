#!/bin/bash

# manila support netprobe64 creation script
# by rgonbaos & incfury for sandbox initiative
# Nov-17-2014

SCRIPT_HOME=/home/sandbox/scripts
BINARY_HOME=/opt/geneos/binaries
USER_HOME=`echo ${HOME}`
PORT_FILE=${SCRIPT_HOME}/.port/.config_port_range.masterlist
PORT_NUM=`grep str_port_number ${PORT_FILE} | awk -F"|" '{print $3}' | awk -F"," '{print $NF}'`
HOST=`echo ${HOSTNAME^^}`

create_netprobe_linux () {
	NP_BINARY=${BINARY_HOME}/netprobe
	NP_START_TEMPLATE=${SCRIPT_HOME}/.template_netprobe_start_linux.txt
    NP_START_TMP=${USER_HOME}/start_netprobe_${TICKET}.bash.tmp
    NP_START=${USER_HOME}/start_netprobe_${TICKET}.bash

    cd ${NP_BINARY}
    ln -sf ${VRSION} ${TICKET}
    cd
    mkdir -p ${TICKET_HOME}/logs

    # create TMP start script
    cat ${NP_START_TEMPLATE} > ${NP_START_TMP}

    # modify TMP start script
    sed -e "s|^TICKET=|TICKET=${TICKET}|1" -e "s|^PORT_NUM=|PORT_NUM=${PORT_NUM}|1" ${NP_START_TMP} > ${NP_START}
                  
    chmod 755 ${NP_START}
    rm ${NP_START_TMP}

    echo -e "Netprobe startup script ${NP_START} created."
	echo -e "Netprobe folder ${TICKET_HOME} created."
    echo -e "Netprobe port: ${PORT_NUM}"
}

create_netprobe_ga4_linux () {
	NP_BINARY=${BINARY_HOME}/netprobe
	NP_START_TEMPLATE=${SCRIPT_HOME}/.template_netprobe_ga4_start_linux.txt
    NP_START_TMP=${USER_HOME}/start_netprobe_${TICKET}.bash.tmp
    NP_START=${USER_HOME}/start_netprobe_${TICKET}.bash
	
	NP_TEMPLATE_FLOATING=${SCRIPT_HOME}/.template_netprobe_floating.xml
	NP_FLOATING=${TICKET_HOME}/netprobe.setup.${TICKET}.floating.xml
	
	NP_TEMPLATE_SELF_ANNOUNCING=${SCRIPT_HOME}/.template_netprobe_self_announcing.xml
	NP_SELF_ANNOUNCING=${TICKET_HOME}/netprobe.setup.${TICKET}.self.announcing.xml

    cd ${NP_BINARY}
    ln -sf ${VRSION} ${TICKET}
    cd
    mkdir -p ${TICKET_HOME}/logs

    # create TMP start script
    cat ${NP_START_TEMPLATE} > ${NP_START_TMP}
	
	# modify TMP start script
    sed -e "s|^TICKET=|TICKET=${TICKET}|1" -e "s|^PORT_NUM=|PORT_NUM=${PORT_NUM}|1" ${NP_START_TMP} > ${NP_START}

	# create floating and self announcing setup files
	cat ${NP_TEMPLATE_FLOATING} > ${NP_FLOATING} 
	cat ${NP_TEMPLATE_SELF_ANNOUNCING} > ${NP_SELF_ANNOUNCING} 
    
    chmod 755 ${NP_START}
    rm ${NP_START_TMP}

    echo -e "Netprobe startup script ${NP_START} created."
	echo -e "Netprobe folder ${TICKET_HOME} created."
    echo -e "Netprobe port: ${PORT_NUM}"
}

create_netprobe_solarisx86 () {
	NP_BINARY=${BINARY_HOME}/netprobe
	NP_START_TEMPLATE=${SCRIPT_HOME}/.template_netprobe_start_solarisx86.txt
    NP_START_TMP=${USER_HOME}/start_netprobe_${TICKET}.bash.tmp
    NP_START=${USER_HOME}/start_netprobe_${TICKET}.bash

	NP_TEMPLATE_FLOATING=${SCRIPT_HOME}/.template_netprobe_floating.xml
	NP_FLOATING=${USER_HOME}/${TICKET_HOME}/netprobe.setup.${TICKET}.floating.xml
	
	NP_TEMPLATE_SELF_ANNOUNCING=${SCRIPT_HOME}/.template_netprobe_self_announcing.xml
	NP_SELF_ANNOUNCING=${USER_HOME}/${TICKET_HOME}/netprobe.setup.${TICKET}.self.announcing.xml

    cd ${NP_BINARY}
    ln -sf ${VRSION} ${TICKET}
    cd
    mkdir -p ${TICKET_HOME}/logs

    # create TMP start script
    cat ${NP_START_TEMPLATE} > ${NP_START_TMP}

    # modify TMP start script
    sed -e "s|^TICKET=|TICKET=${TICKET}|1" -e "s|^PORT_NUM=|PORT_NUM=${PORT_NUM}|1" ${NP_START_TMP} > ${NP_START}

	# create floating and self announcing setup files
	cat ${NP_TEMPLATE_FLOATING} > ${NP_FLOATING} 
	cat ${NP_TEMPLATE_SELF_ANNOUNCING} > ${NP_SELF_ANNOUNCING} 

    chmod 755 ${NP_START}
    rm ${NP_START_TMP}

    echo -e "Netprobe startup script ${NP_START} created."
	echo -e "Netprobe folder ${TICKET_HOME} created."
    echo -e "Netprobe port: ${PORT_NUM}"
}

create_netprobe_ga4_solarisx86 () {
	NP_BINARY=${BINARY_HOME}/netprobe
	NP_START_TEMPLATE=${SCRIPT_HOME}/.template_netprobe_ga4_start_solarisx86.txt
    NP_START_TMP=${USER_HOME}/start_netprobe_${TICKET}.bash.tmp
    NP_START=${USER_HOME}/start_netprobe_${TICKET}.bash

    cd ${NP_BINARY}
    ln -sf ${VRSION} ${TICKET}
    cd
    mkdir -p ${TICKET_HOME}/logs

    # create TMP start script
    cat ${NP_START_TEMPLATE} > ${NP_START_TMP}

    # modify TMP start script
    sed -e "s|^TICKET=|TICKET=${TICKET}|1" -e "s|^PORT_NUM=|PORT_NUM=${PORT_NUM}|1" ${NP_START_TMP} > ${NP_START}
                  
    chmod 755 ${NP_START}
    rm ${NP_START_TMP}

    echo -e "Netprobe startup script ${NP_START} created."
	echo -e "Netprobe folder ${TICKET_HOME} created."
    echo -e "Netprobe port: ${PORT_NUM}"
}

create_fix_linux () {
    NP_BINARY=${BINARY_HOME}/fix-analyser2
    NP_START_TEMPLATE=${SCRIPT_HOME}/.template_fix_start_linux.txt
	NP_START_TMP=${USER_HOME}/start_fix_${TICKET}.bash.tmp
    NP_START=${USER_HOME}/start_fix_${TICKET}.bash

    cd ${NP_BINARY}
    ln -sf ${VRSION} ${TICKET}
    cd
    mkdir -p ${TICKET_HOME}/logs

    # create TMP start script
    cat ${NP_START_TEMPLATE} > ${NP_START_TMP}

    # modify TMP start script
    sed -e "s|^TICKET=|TICKET=${TICKET}|1" -e "s|^PORT_NUM=|PORT_NUM=${PORT_NUM}|1" ${NP_START_TMP} > ${NP_START}
                  
    chmod 755 ${NP_START}
    rm ${NP_START_TMP}

    echo -e "FIX Analyser Netprobe startup script ${NP_START} created."
	echo -e "FIX Analyser Netprobe folder ${TICKET_HOME} created."
    echo -e "FIX Analyser Netprobe port: ${PORT_NUM}"
}

create_fix_ga4_linux () {
    NP_BINARY=${BINARY_HOME}/fix-analyser2
    NP_START_TEMPLATE=${SCRIPT_HOME}/.template_fix_ga4_start_linux.txt
    NP_START_TMP=${USER_HOME}/start_fix_${TICKET}.bash.tmp
    NP_START=${USER_HOME}/start_fix_${TICKET}.bash

    cd ${NP_BINARY}
    ln -sf ${VRSION} ${TICKET}
    cd
    mkdir -p ${TICKET_HOME}/logs

    # create TMP start script
    cat ${NP_START_TEMPLATE} > ${NP_START_TMP}

    # modify TMP start script
    sed -e "s|^TICKET=|TICKET=${TICKET}|1" -e "s|^PORT_NUM=|PORT_NUM=${PORT_NUM}|1" ${NP_START_TMP} > ${NP_START}
                  
    chmod 755 ${NP_START}
    rm ${NP_START_TMP}

    echo -e "FIX Analyser Netprobe startup script ${NP_START} created."
    echo -e "FIX Analyser Netprobe folder ${TICKET_HOME} created."
    echo -e "FIX Analyser Netprobe port: ${PORT_NUM}"
}

create_fix_file_agent_ga4_linux () {
    NP_BINARY=${BINARY_HOME}/file-agent
    NP_START_TEMPLATE=${SCRIPT_HOME}/.template_fix_file_agent_ga4_start_linux.txt
    NP_START_TMP=${USER_HOME}/start_fix_file_agent_${TICKET}.bash.tmp
    NP_START=${USER_HOME}/start_fix_file_agent_${TICKET}.bash

    cd ${NP_BINARY}
    ln -sf ${VRSION} ${TICKET}
    cd
    #mkdir -p ${TICKET_HOME}/logs

    # create TMP start script
    cat ${NP_START_TEMPLATE} > ${NP_START_TMP}

    # modify TMP start script
    sed -e "s|^TICKET=|TICKET=${TICKET}|1" -e "s|^PORT_NUM=|PORT_NUM=${PORT_NUM}|1" ${NP_START_TMP} > ${NP_START}

    chmod 755 ${NP_START}
    rm ${NP_START_TMP}

    echo -e "FIX File Agent startup script ${NP_START} created."
    echo -e "FIX File Agent folder ${TICKET_HOME} created."
    echo -e "FIX File Agent port: ${PORT_NUM}"
}


create_euem_linux () {
    NP_BINARY=${BINARY_HOME}/euem-netprobe
    NP_START_TEMPLATE=${SCRIPT_HOME}/.template_euem_start_linux.txt
	NP_START_TMP=${USER_HOME}/start_euem_${TICKET}.bash.tmp
    NP_START=${USER_HOME}/start_euem_${TICKET}.bash

    cd ${NP_BINARY}
    ln -sf ${VRSION} ${TICKET}
    cd
    mkdir -p ${TICKET_HOME}/logs

    # create TMP start script
    cat ${NP_START_TEMPLATE} > ${NP_START_TMP}

    # modify TMP start script
    sed -e "s|^TICKET=|TICKET=${TICKET}|1" -e "s|^PORT_NUM=|PORT_NUM=${PORT_NUM}|1" ${NP_START_TMP} > ${NP_START}
                  
    chmod 755 ${NP_START}
    rm ${NP_START_TMP}

    echo -e "EUEM Netprobe startup script ${NP_START} created."
	echo -e "EUEM Netprobe folder ${TICKET_HOME} created."
    echo -e "EUEM Netprobe port: ${PORT_NUM}"
}

create_euem_ga4_linux () {
    NP_BINARY=${BINARY_HOME}/euem-netprobe
    NP_START_TEMPLATE=${SCRIPT_HOME}/.template_euem_ga4_start_linux.txt
	NP_START_TMP=${USER_HOME}/start_euem_${TICKET}.bash.tmp
    NP_START=${USER_HOME}/start_euem_${TICKET}.bash

    cd ${NP_BINARY}
    ln -sf ${VRSION} ${TICKET}
    cd
    mkdir -p ${TICKET_HOME}/logs

    # create TMP start script
    cat ${NP_START_TEMPLATE} > ${NP_START_TMP}

    # modify TMP start script
    sed -e "s|^TICKET=|TICKET=${TICKET}|1" -e "s|^PORT_NUM=|PORT_NUM=${PORT_NUM}|1" ${NP_START_TMP} > ${NP_START}
                  
    chmod 755 ${NP_START}
    rm ${NP_START_TMP}

    echo -e "EUEM Netprobe startup script ${NP_START} created."
	echo -e "EUEM Netprobe folder ${TICKET_HOME} created."
    echo -e "EUEM Netprobe port: ${PORT_NUM}"
}

update_port_range_ctl_file () {
    STR_PORT=`grep str_port_number ${PORT_FILE} | awk -F"|" '{print $1}' | awk -F"," '{print $NF}'`
    END_PORT=`grep str_port_number ${PORT_FILE} | awk -F"|" '{print $2}' | awk -F"," '{print $NF}'`
    CUR_PORT=`grep str_port_number ${PORT_FILE} | awk -F"|" '{print $3}' | awk -F"," '{print $NF}'`
    
    # check port range file to assign next user port number
    if [ ${CUR_PORT} -ge ${END_PORT} ]
    then
            NEW_PORT=${STR_PORT}
    else
            NEW_PORT=`expr ${CUR_PORT} + 1`
    fi
    NEWLINE=`grep str_port_number ${PORT_FILE} | sed "s|cur_port_number.*|cur_port_number,${NEW_PORT}|1"`
    grep ^# ${PORT_FILE}> ${PORT_FILE}.tmp
    #(grep -v ${USERNAME} ${PORT_FILE} | grep -v ^#; echo ${NEWLINE}) | sort -d >> ${PORT_FILE}.tmp
    (grep -v str_port_number ${PORT_FILE} | grep -v ^#; echo ${NEWLINE}) | sort -d >> ${PORT_FILE}.tmp
    cat ${PORT_FILE}.tmp > ${PORT_FILE}
    rm -f ${PORT_FILE}.tmp
#   echo -e "Next port number to use: ${NEW_PORT}"
}

### MAIN PROGRAM

read -p "Please enter Ticket number: " TICKET
if [[ ${TICKET} != '^[0-9]+$' ]] && [ ! -z "${TICKET}" -a "${TICKET}" != " " ]; then
	echo -e "\tTicket number ${TICKET} accepted. Thank you"
	sleep 1
	#read -p "Please enter Netprobe type (1=Netprobe, 2=FIX, 3=EUEM): " BIN_TYPE
	read -p "Please enter Netprobe type (1=Netprobe, 2=FIX): " BIN_TYPE
	TICKET_HOME=${USER_HOME}/tickets/${TICKET}
	if [ ${BIN_TYPE} = 1 ]; then
		NP_BINARY=${BINARY_HOME}/netprobe
		ls -l ${NP_BINARY}
		read -p "Please enter Netprobe 64-bit version: " VRSION
			if [ `ls -d ${NP_BINARY}/${VRSION} 2>/dev/null | wc -l` != 1 ]; then
				echo -e "\tNetprobe 64-bit version ${VRSION} not found. Please check binaries in ${NP_BINARY}"
				sleep 1
				echo -e "\tSorry. Bye-bye. (,o__o)/"
				sleep 1
				exit
			else
				echo -e "\tNetprobe 64-bit version ${VRSION} accepted. Thank you."
				sleep 1
				if [ `echo ${VRSION} | grep GA3 | wc -l` != 1 ]; then
					if [ `uname -a | cut -d" " -f1` = "Linux" ]; then
						create_netprobe_ga4_linux
					else
						create_netprobe_ga4_solarisx86
					fi
				else
					if [ `uname -a | cut -d" " -f1` = "Linux" ]; then
						create_netprobe_linux
					else
						create_netprobe_solarisx86
					fi
				fi
				sleep 2
				update_port_range_ctl_file
				exit
			fi
	elif [ ${BIN_TYPE} = 2 ]; then
			NP_BINARY=${BINARY_HOME}/fix-analyser2
			ls -l ${NP_BINARY}
			read -p "Please enter FIX Analyser Netprobe version: " VRSION
			if [ `ls -d ${NP_BINARY}/${VRSION} 2>/dev/null | wc -l` != 1 ]; then
				echo -e "\tFIX Analyser Netprobe ${VRSION} not found. Please check binaries in ${NP_BINARY}"
				sleep 1
				echo -e "\tSorry. Bye-bye. (,o__o)/"
				sleep 1
				exit
			else
				echo -e "\tFIX Analyser Netprobe version ${VRSION} accepted. Thank you."
				sleep 1
				if [ `echo ${VRSION} | grep GA3 | wc -l` != 1 ]; then
					create_fix_ga4_linux
				else
					create_fix_linux
				fi
				sleep 2
				update_port_range_ctl_file
			fi
			PORT_NUM=`grep str_port_number ${PORT_FILE} | awk -F"|" '{print $3}' | awk -F"," '{print $NF}'`
			NP_BINARY=${BINARY_HOME}/file-agent
                        ls -l ${NP_BINARY}
                        read -p "Please enter FIX File Agent version: " VRSION
                        if [ `ls -d ${NP_BINARY}/${VRSION} 2>/dev/null | wc -l` != 1 ]; then
                                echo -e "\tFIX File Agent ${VRSION} not found. Please check binaries in ${NP_BINARY}"
                                sleep 1
                                echo -e "\tSorry. Bye-bye. (,o__o)/"
                                sleep 1
                                exit
                        else
                                echo -e "\tFIX File Agent version ${VRSION} accepted. Thank you."
                                sleep 1
                                if [ `echo ${VRSION} | grep GA3 | wc -l` != 1 ]; then
					create_fix_file_agent_ga4_linux
                                else
                                        create_fix_file_agent_linux
                                fi
                                sleep 2
                                update_port_range_ctl_file
				exit
                        fi
	#elif [ ${BIN_TYPE} = 3 ]; then
	#	NP_BINARY=${BINARY_HOME}/euem-netprobe
	#	ls -l ${NP_BINARY}
	#	read -p "Please enter EUEM Netprobe version: " VRSION
	#	if [ `ls -d ${NP_BINARY}/${VRSION} 2>/dev/null | wc -l` != 1 ]; then
	#		echo -e "\tEUEM Netprobe ${VRSION} not found. Please check binaries in ${NP_BINARY}"
	#		sleep 1
	#		echo -e "\tSorry. Bye-bye. (,o__o)/"
	#		sleep 1
	#		exit
	#	else
	#		echo -e "\tEUEM Netprobe version ${VRSION} accepted. Thank you."
	#		sleep 1
	#		if [ `echo ${VRSION} | grep GA3 | wc -l` != 1 ]; then
	#			create_euem_ga4_linux
	#		else
	#			create_euem_linux
	#		fi
	#		sleep 2
	#		update_port_range_ctl_file
	#		exit
	#	fi
	else
		echo -e "\tInvalid choice ${BIN_TYPE}"
	fi
else
	echo -e "\tInvalid Ticket number ${TICKET}"
	sleep 1
	echo -e "\tSorry. Bye-bye. (,o__o)/"
	sleep 1
	exit
fi

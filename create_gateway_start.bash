#!/bin/bash

# manila support gateway creation script
# by rgonbaos & incfury for sandbox initative
# Nov-17-2014

SCRIPT_HOME=/home/sandbox/scripts
BINARY_HOME=/opt/geneos/binaries
USER_HOME=`echo ${HOME}`
PORT_FILE=${SCRIPT_HOME}/.port/.config_port_range.masterlist
GW_BINARY=${BINARY_HOME}/gateway
PORT_NUM=`grep str_port_number ${PORT_FILE} | awk -F"|" '{print $3}' | awk -F"," '{print $NF}'`
HOST=`echo ${HOSTNAME^^}`


create_gateway_linux () {
	GW_START_TEMPLATE=${SCRIPT_HOME}/.template_gateway_ga4_start_linux.txt
	GW_SETUP_TMP=${GW_BINARY}/${VRSION}/templates/gateway.setup.xml.tmpl

    cd ${GW_BINARY}
    ln -sf ${VRSION} ${TICKET}
    cd
    mkdir -p ${TICKET_HOME}/setup/includes ${TICKET_HOME}/logs
	cd ${TICKET_HOME}
	ln -sf ${GW_BINARY}/${TICKET}/resources resources
	cd
	
    # create TMP start script
    cat ${GW_START_TEMPLATE} > ${GW_START_TMP}

    # modify TMP start script
    sed -e "s|TICKET=|TICKET=${TICKET}|1" ${GW_START_TMP} > ${GW_START}
    
    # modify setup XML template to create setup XML
        if [ `grep Demo ${GW_SETUP_TMP} | wc -l` != 1 ]; then
                sed -e "s|<listenPort>7039</listenPort>|<listenPort>${PORT_NUM}</listenPort>|1" -e "s|<gatewayName></gatewayName>|<gatewayName>MNL_${HOST}_GATEWAY_${TICKET}</gatewayName>|1" ${GW_SETUP_TMP} > ${GW_SETUP}
        else
                sed -e "s|<listenPort>7039</listenPort>|<listenPort>${PORT_NUM}</listenPort>|1" -e "s|<gatewayName>Demo Gateway</gatewayName>|<gatewayName>MNL_${HOST}_GATEWAY_${TICKET}</gatewayName>|1" ${GW_SETUP_TMP} > ${GW_SETUP}
        fi
	
    chmod 755 ${GW_START}
    rm ${GW_START_TMP}

    echo -e "Gateway 64-bit startup script ${GW_START} created."
	echo -e "Gateway 64-bit folder ${TICKET_HOME} created."
    echo -e "Gateway 64-bit name: MNL_${HOST}_GATEWAY_${TICKET}"
    echo -e "Gateway 64-bit port: ${PORT_NUM}"
}

create_gateway_ga4_linux () {
	GW_START_TEMPLATE=${SCRIPT_HOME}/.template_gateway_ga4_start_linux.txt
	GW_SETUP_TMP=${GW_BINARY}/${VRSION}/gateway/templates/gateway.setup.xml.tmpl

    cd ${GW_BINARY}
    ln -sf ${VRSION} ${TICKET}
    cd
    mkdir -p ${TICKET_HOME}/setup/includes ${TICKET_HOME}/logs
	cd ${TICKET_HOME}
	ln -sf ${GW_BINARY}/${TICKET}/gateway/resources resources
	cd
	
    # create TMP start script
    cat ${GW_START_TEMPLATE} > ${GW_START_TMP}

    # modify TMP start script
    sed -e "s|TICKET=|TICKET=${TICKET}|1" ${GW_START_TMP} > ${GW_START}
    
    # modify setup XML template to create setup XML
        if [ `grep Demo ${GW_SETUP_TMP} | wc -l` != 1 ]; then
                sed -e "s|<listenPort>7039</listenPort>|<listenPort>${PORT_NUM}</listenPort>|1" -e "s|<gatewayName></gatewayName>|<gatewayName>MNL_${HOST}_GATEWAY_${TICKET}</gatewayName>|1" ${GW_SETUP_TMP} > ${GW_SETUP}
        else
                sed -e "s|<listenPort>7039</listenPort>|<listenPort>${PORT_NUM}</listenPort>|1" -e "s|<gatewayName>Demo Gateway</gatewayName>|<gatewayName>MNL_${HOST}_GATEWAY_${TICKET}</gatewayName>|1" ${GW_SETUP_TMP} > ${GW_SETUP}
        fi
	
    chmod 755 ${GW_START}
    rm ${GW_START_TMP}

    echo -e "Gateway 64-bit startup script ${GW_START} created."
	echo -e "Gateway 64-bit folder ${TICKET_HOME} created."
    echo -e "Gateway 64-bit name: MNL_${HOST}_GATEWAY_${TICKET}"
    echo -e "Gateway 64-bit port: ${PORT_NUM}"
}

create_gateway_solarisx86 () {
	GW_START_TEMPLATE=${SCRIPT_HOME}/.template_gateway_ga4_start_solarisx86.txt
	GW_SETUP_TMP=${GW_BINARY}/${VRSION}/templates/gateway.setup.xml.tmpl

    cd ${GW_BINARY}
    ln -sf ${VRSION} ${TICKET}
    cd
    mkdir -p ${TICKET_HOME}/setup/includes ${TICKET_HOME}/logs
	cd ${TICKET_HOME}
	ln -sf ${GW_BINARY}/${TICKET}/resources resources
	cd
	
    # create TMP start script
    cat ${GW_START_TEMPLATE} > ${GW_START_TMP}

    # modify TMP start script
    sed -e "s|TICKET=|TICKET=${TICKET}|1" ${GW_START_TMP} > ${GW_START}
    
    # modify setup XML template to create setup XML
    sed -e "s|<listenPort>7039</listenPort>|<listenPort>${PORT_NUM}</listenPort>|1" -e "s|<gatewayName></gatewayName>|<gatewayName>MNL_${HOST}_GATEWAY_${TICKET}</gatewayName>|1" ${GW_SETUP_TMP} > ${GW_SETUP}
	
    chmod 755 ${GW_START}
    rm ${GW_START_TMP}

    echo -e "Gateway 64-bit startup script ${GW_START} created."
	echo -e "Gateway 64-bit folder ${TICKET_HOME} created."
    echo -e "Gateway 64-bit name: MNL_${HOST}_GATEWAY_${TICKET}"
    echo -e "Gateway 64-bit port: ${PORT_NUM}"
}

create_gateway_ga4_solarisx86 () {
	GW_START_TEMPLATE=${SCRIPT_HOME}/.template_gateway_ga4_start_solarisx86.txt
	GW_SETUP_TMP=${GW_BINARY}/${VRSION}/gateway/templates/gateway.setup.xml.tmpl

    cd ${GW_BINARY}
    ln -sf ${VRSION} ${TICKET}
    cd
    mkdir -p ${TICKET_HOME}/setup/includes ${TICKET_HOME}/logs
	cd ${TICKET_HOME}
	ln -sf ${GW_BINARY}/${TICKET}/gateway/resources resources
	cd
	
    # create TMP start script
    cat ${GW_START_TEMPLATE} > ${GW_START_TMP}

    # modify TMP start script
    sed -e "s|TICKET=|TICKET=${TICKET}|1" ${GW_START_TMP} > ${GW_START}
    
    # modify setup XML template to create setup XML
    sed -e "s|<listenPort>7039</listenPort>|<listenPort>${PORT_NUM}</listenPort>|1" -e "s|<gatewayName></gatewayName>|<gatewayName>MNL_${HOST}_GATEWAY_${TICKET}</gatewayName>|1" ${GW_SETUP_TMP} > ${GW_SETUP}
	
    chmod 755 ${GW_START}
    rm ${GW_START_TMP}

    echo -e "Gateway 64-bit startup script ${GW_START} created."
	echo -e "Gateway 64-bit folder ${TICKET_HOME} created."
    echo -e "Gateway 64-bit name: MNL_${HOST}_GATEWAY_${TICKET}"
    echo -e "Gateway 64-bit port: ${PORT_NUM}"
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

## MAIN PROGRAM

read -p "Please enter Ticket number: " TICKET
if [[ ${TICKET} != '^[0-9]+$' ]] && [ ! -z "${TICKET}" -a "${TICKET}" != " " ]; then
    echo -e "\tTicket number ${TICKET} accepted. Thank you"
    sleep 1
    ls -l ${GW_BINARY}
	read -p "Please enter Gateway 64-bit version: " VRSION
    if [ `ls -d ${GW_BINARY}/${VRSION} 2>/dev/null | wc -l` != 1 ]; then
        echo -e "\tGateway 64-bit version ${VRSION} not found. Please check binaries in ${GW_BINARY}"
        sleep 1
        echo -e "\tSorry. Bye-bye. (,o__o)/"
        sleep 1
        exit
    else
		TICKET_HOME=${USER_HOME}/tickets/${TICKET}
		GW_START_TMP=${USER_HOME}/start_gateway_${TICKET}.bash.tmp
		GW_START=${USER_HOME}/start_gateway_${TICKET}.bash
		GW_SETUP=${TICKET_HOME}/setup/gateway.setup.${TICKET}.xml
        echo -e "\tGateway 64-bit version ${VRSION} accepted. Thank you."
        sleep 1
		if [ `echo ${VRSION} | grep GA3 | wc -l` != 1 ]; then
			if [ `uname -a | cut -d" " -f1` = "Linux" ]; then
				create_gateway_ga4_linux
			else
				create_gateway_ga4_solarisx86
			fi
		else
			if [ `uname -a | cut -d" " -f1` = "Linux" ]; then
				create_gateway_linux
			else
				create_gateway_solarisx86
			fi
		fi
		sleep 2
		update_port_range_ctl_file
		exit
    fi
else
	echo -e "\tInvalid Ticket number ${TICKET}"
	sleep 1
	echo -e "\tSorry. Bye-bye. (,o__o)/"
	sleep 1
	exit
fi

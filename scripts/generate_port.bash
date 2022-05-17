#!/bin/bash

# port generator
# by rgonbaos & incfury for sandbox initative
# Sep-4-2015

SCRIPT_HOME=/home/sandbox/scripts
PORT_FILE=${SCRIPT_HOME}/.port/.config_port_range.masterlist
USERNAME=`whoami`

PORT_NUM=`grep str_port_number ${PORT_FILE} | awk -F"|" '{print $3}' | awk -F"," '{print $NF}'`

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
#       echo -e "Next port number to use: ${NEW_PORT}"
}

## MAIN PROGRAM

echo ${PORT_NUM}
update_port_range_ctl_file

exit
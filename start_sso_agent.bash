#!/bin/bash

USER_HOME=`echo ${HOME}`
SSO_DIR=/opt/geneos/binaries/sso/prod

# Check if process is running
USERNAME=`who -m | tr -s " " | cut -d" " -f1`
PID=`ps -ef | grep ${USERNAME} | grep "sso/prod"| grep -w "bin/java" | tr -s "" | awk '{print $2}'`
if [[ $1 == "restart" ]]; then
        kill ${PID}
        sleep 1
        echo -e "\tStopping the SSO process."
        PID=`ps -ef | grep ${USERNAME} | grep "sso/prod"| grep -w "bin/java" | tr -s "" | awk '{print $2}'`
        if [[ ! -z ${PID} ]]; then
                sleep 1
                echo -e "\tStopping the SSO process using kill -9."
                kill -9 ${PID}
        fi
        echo -e "\tStarting the SSO process."
        ./start_sso_agent.bash
        exit
elif [[ $1 == "stop" ]]; then
        kill ${PID}
        sleep 1
        echo -e "\tStopping the SSO process."
        PID=`ps -ef | grep ${USERNAME} | grep "sso/prod"| grep -w "bin/java" | tr -s "" | awk '{print $2}'`
        if [[ ! -z ${PID} ]]; then
                sleep 1
                echo -e "\tStopping the SSO process using kill -9."
                kill -9 ${PID}
        fi
	exit
elif [[ ! -z ${PID} ]]; then
        echo -e "\tPID $PID is already running. Stop the process first."
        sleep 1
        exit
else

	# Start the Geneos SSO Agent binary
	cd ${SSO_DIR}
	rm nohup.out
	nohup ./bin/sso-agent &
fi
exit

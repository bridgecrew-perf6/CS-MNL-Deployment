#!/bin/bash

LICD_PROD_DIR="/opt/geneos/binaries/licd/prod/licd"
export LOG_FILENAME="${LICD_PROD_DIR}/licd_prod.log"

cd ${LICD_PROD_DIR}
rm nohup.out
nohup ./licd.linux_64 &

exit

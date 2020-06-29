#!/bin/bash
set -e

DIST_PATH=js-docker/resources

DIST_VER=7.5.0
DIST_NAME=TIB_js-jrs-cp_${DIST_VER}_bin.zip
DIST_DIR=${DIST_NAME%.*}
DIST_URL="https://sourceforge.net/projects/jasperserver/files/JasperServer/JasperReports%20Server%20Community%20edition%20${DIST_VER}/${DIST_NAME}/download"

rollback() {
    echo -e "\nDIST: Aborted..."
    rm $DIST_PATH/$DIST_NAME
	exit 1
}

unpack() {
	echo "DIST: Dist archive is found. Unpacking..."
	unzip -o -q $DIST_PATH/$DIST_NAME -d $DIST_PATH
	cd $DIST_PATH/jasperreports-server-cp-${DIST_VER}-bin || exit
	echo "DIST: Unpacking WAR..."
	unzip -o -q jasperserver.war -d jasperserver
	echo "DIST: Removing WAR..."
	rm jasperserver.war
	echo "DIST: Done!"
}

download_dist() {
    echo "DIST: Dist archive is not found. Downloading..."
    wget $DIST_URL -O $DIST_PATH/$DIST_NAME && unpack || rollback
}

if [[ ! -d $DIST_PATH/$DIST_DIR ]]; then
	echo "DIST: Folder with dist not found... Checking if dist archive is present..."
	[[ ! -f $DIST_PATH/$DIST_NAME ]] && download_dist || unpack
else
	echo "DIST: Folder with dist found... No actions needed."
	exit 0
fi

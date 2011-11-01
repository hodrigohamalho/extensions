#!/bin/sh
############################################################
#
# Simple script to rename the portal container 'ecmdemo' to
# the new name passed through parameter.
#
# After usage this script remember to rename the <jndi-name>
# in file wcm-ds.xml to gatein-idm_newname and gatein-jcr_newname
#
# arg 0: new container name.
# arg 1: ear name of eppsp.ear (unexploded)
#
# @author Rodrigo Ramalho (hodrigohamalho@gmail.com)
# @version 0.1
#
############################################################

NEW_CONTAINER_NAME=$1
EAR_NAME=$2

function explodeFiles(){
  FILE_TO_EXPLODE=$1
	echo "Exploding: $FILE_TO_EXPLODE ... "
	
  unzip -q $FILE_TO_EXPLODE -d $FILE_TO_EXPLODE.'exploded'
  rm $FILE_TO_EXPLODE
  mv $FILE_TO_EXPLODE.'exploded' $FILE_TO_EXPLODE 
}

function replaceTextReferences(){
	echo "Replacing ecmdemo references to $NEW_CONTAINER_NAME ... "
	
  FILES=$(find $EAR_NAME -name "*ecmdemo*")
  find $EAR_NAME -type f -exec sed -i "" -e s/ecmdemo/"$NEW_CONTAINER_NAME"/g {} \;
}

function renameFilesAndDirs(){
  echo "Renaming files and dirs... "

  FILES=$(find $EAR_NAME -name "*ecmdemo*")
  for FILE in $FILES; do
    NAME="$FILE"
    NAME_REPLACED=$(echo $FILE | sed -e s/ecmdemo/"$NEW_CONTAINER_NAME"/g)
    mv $NAME $NAME_REPLACED
  done
}

if [ $# -lt 1 ] ; then
  echo "Wrong number of parameters."
  echo "Usage:"
  echo "./change_gatein_portalcontainer.sh newContainerName gatein-eppspdemo-portal-2.1.5-CP02.ear \n"
  exit 1
fi

#############################################################
#
# Script Begin
#
#############################################################

explodeFiles $EAR_NAME &&
explodeFiles $EAR_NAME/ecmdemo.war &&
explodeFiles $EAR_NAME/rest-ecmdemo.war &&
explodeFiles $EAR_NAME/lib/exo-ecms-packaging-ecmdemo-config-2.1.5-CP02.jar &&

replaceTextReferences &&
renameFilesAndDirs 

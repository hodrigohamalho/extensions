#!/bin/sh

#arg 0: new container name.
#arg 1: ear name of eppsp.ear (unexploded)

if [ $# -lt 1 ] ; then
  echo "Wrong number of parameters."
  echo "Usage:"
  echo "./rename_all newContainerName \n"
  exit 1
fi

echo "Explodind files..."

NEW_CONTAINER_NAME=$1
EAR_NAME=$2

echo "Exploding $EAR_NAME"
unzip $EAR_NAME -d $EAR_NAME.'exploded' &&
rm $EAR_NAME &&
mv $EAR_NAME.'exploded' $EAR_NAME &&

echo "Exploding $EAR_NAME/ecmdemo.war" &&
unzip $EAR_NAME/ecmdemo.war -d $EAR_NAME/ecmdemo.war.exploded &&
rm $EAR_NAME/ecmdemo.war &&
mv $EAR_NAME/ecmdemo.war.exploded $EAR_NAME/ecmdemo.war &&

echo "Exploding $EAR_NAME/rest-ecmdemo.war" &&
unzip $EAR_NAME/rest-ecmdemo.war -d $EAR_NAME/rest-ecmdemo.war.exploded &&
rm $EAR_NAME/rest-ecmdemo.war &&
mv $EAR_NAME/rest-ecmdemo.war.exploded $EAR_NAME/rest-ecmdemo.war &&

echo "Exploding $EAR_NAME/lib/exo-ecms-packaging-ecmdemo-config-2.1.5-CP02.jar" &&
unzip $EAR_NAME/lib/exo-ecms-packaging-ecmdemo-config-2.1.5-CP02.jar -d $EAR_NAME/lib/exo-ecms-packaging-ecmdemo-config-2.1.5-CP02.jar.exploded &&
rm $EAR_NAME/lib/exo-ecms-packaging-ecmdemo-config-2.1.5-CP02.jar &&
mv $EAR_NAME/lib/exo-ecms-packaging-ecmdemo-config-2.1.5-CP02.jar.exploded $EAR_NAME/lib/exo-ecms-packaging-ecmdemo-config-2.1.5-CP02.jar &&

FILES_PATH="."
FILES=$(find $FILES_PATH -name "*ecmdemo*")

echo "Substituindo todas referencias de ecmdemo para $NEW_CONTAINER_NAME"

find . -type f -exec sed -i "" -e s/ecmdemo/"$NEW_CONTAINER_NAME"/g {} \;

echo "Referencias atualizadas."

echo "Renomeando arquivos e diretorios..."

for FILE in $FILES; do
  NAME="$FILE"
  NAME_REPLACED=$(echo $FILE | sed -e s/ecmdemo/"$NEW_CONTAINER_NAME"/g)
  mv $NAME $NAME_REPLACED
done

echo "Arquivos e diretorios atualizados."


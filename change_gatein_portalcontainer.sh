#!/bin/sh

#arg 0: new container name.

if [ $# -lt 1 ] ; then
  echo "Wrong number of parameters."
  echo "Usage:"
  echo "./rename_all newContainerName \n"
  exit 1
fi

FILES_PATH="."
FILES=$(find $FILES_PATH -name "*ecmdemo*")

echo "Substituindo todas referencias de ecmdemo para $1"

find . -type f -exec sed -i "" -e s/ecmdemo/"$1"/g {} \;

echo "Referencias atualizadas."

echo "Renomeando arquivos e diretorios..."

for FILE in $FILES; do
  NAME="$FILE"
  NAME_REPLACED=$(echo $FILE | sed -e s/ecmdemo/"$1"/g)
  mv $NAME $NAME_REPLACED
done

echo "Arquivos e diretorios atualizados."


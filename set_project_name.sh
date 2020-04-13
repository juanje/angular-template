#!/bin/bash

# This sript will change the project name.
# I'll change all the files where the projectname is currently being used.
#

OLDNAME="PROYECTO"

FILES="angular.json \
       package.json \
       package-lock.json \
       karma.conf.js
       src/app/app.component.ts \
       src/app/app.component.spec.ts \
       e2e/src/app.e2e-spec.ts"
FILES_CAP="README.md src/index.html"

echo "The current project name is '${OLDNAME}', please enter the new project name:"
read -r NEWNAME

for filename in ${FILES}; do
    sed -i "s/${OLDNAME}/${NEWNAME}/g" "${filename}"
done

OLDNAME_CAP=${OLDNAME^}
NEWNAME_CAP=${NEWNAME^}
for filename in ${FILES_CAP}; do
    sed -i "s/${OLDNAME_CAP}/${NEWNAME_CAP}/g" "${filename}"
done

echo "The files has been changed with the new project name: ${NEWNAME}"
echo "These are the files changed:"
for filename in ${FILES} ${FILES_CAP}; do
    grep -i --color "${NEWNAME}" "${filename}"
done
echo

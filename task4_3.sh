#!/bin/bash
DESTINATION=/tmp/backups
#This the special variable that will be used in the name of the backup
mod_name=$(echo "$1" | sed  's@/@-@g;s/^-//;s/-$//')

#echo $mod_name

# The variable numcheck stands for checking if the correct positional param has been passed
numcheck='^[0-9]+$'
BACKUPTIME=$(date +%Y-%m-%d-%H:%M:%S:%3N)

#SOURCEFOLDER=$1
if [ ! -d "${DESTINATION}" ]
then mkdir -p "${DESTINATION}"
fi
#The check if the correct number of the positional parameters has been passed.
if [[ $# != 2 ]]
then
echo "the incorrect number of the positional parameters has been passed.
This script requires 2 positional parameters to be passed"
exit 1
fi
#
if ! [[ $2 =~ $numcheck ]]
then
echo "the second positional parameter should be a number"
exit 1
fi
#echo $DESTINATION
tar -cpzf "${DESTINATION}"/"${mod_name}"-"${BACKUPTIME}".tar.gz $1 &>/dev/null
backupsnum=$(find /tmp/backups/ -type f -name "${mod_name}*.tar.gz" | wc -l)
#echo $backupsnum
if [[ $backupsnum > $2 ]]
then 
backdiff=$(( $backupsnum - $2 ))
find /tmp/backups/ -type f -name "${mode_name}*.tar.gz" | sort | head -n"${backdiff}" | xargs -d "\n" rm
fi




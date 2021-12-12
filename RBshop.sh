#!/bin/bash

USER_UID=$(id -u)

if [ ${USER_UID} -ne 0 ]; then

  echo -e "/e[31m Please run the script as a root user /e[m"

exit
fi

components=$1

if [ -z "${components}" ]; then

  echo -e "/e[33m Component Input is missing /e[m"

exit
fi

if [ -ne components/${components}.sh ]; then

  echo -e "/e[34m Components Script is missing /e[m"

exit

fi

bash components/${components}.sh

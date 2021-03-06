#!/bin/bash

USER_UID="$(id -u)"

if [ "${USER_UID}" -ne 0 ]; then

  echo -e "\e[31m Please run the script as a root user \e[m"

exit
fi

export Components=$1

if [ -z "${Components}" ]; then

  echo -e "\e[33m Component Input is missing \e[m"

exit
fi

if [ ! -e Components/"${Components}".sh ]; then

  echo -e "\e[34m Components Script is missing \e[m"

exit

fi

bash Components/"${Components}".sh

#!/bin/bash
#
# oem at oemden dot com - Munki Conditions
#
# Writes Names conditions : Illustrator presence for Illustrator plugin install
# as now CC apps are installed by users... 
# we need to check the presence of the Apps for plugins to get installed or not.
## - - - - - - - - - - - - - - - - - - - - - - -
#
version="1.0"
#
## Conditions in manifest: 
## IllustratorCC2017 == 'TRUE'
## IllustratorCC2018 == 'TRUE'
## IllustratorCC2019 == 'TRUE'
##
DEFAULTS=/usr/bin/defaults
MUNKI_DIR=$("${DEFAULTS}" read /Library/Preferences/ManagedInstalls ManagedInstallDir)
COND_DOMAIN="${MUNKI_DIR}/ConditionalItems"

IllustratorCC2017="/Applications/Adobe Illustrator CC 2017/Adobe Illustrator CC 2017.app"
IllustratorCC2018="/Applications/Adobe Illustrator CC 2018/Adobe Illustrator CC 2018.app"
IllustratorCC2019="/Applications/Adobe Illustrator CC 2019/Adobe Illustrator CC 2019.app"

IllustratorList=( "${IllustratorCC2017}" "${IllustratorCC2018}" "${IllustratorCC2019}" )

for Illustrator in "${IllustratorList[@]}" ; do
 if [[ -d "${Illustrator}" ]] ; then 
  if [[ "${Illustrator}" =~ "2017" ]] ; then
   ## write munki condition Illustrator CC2017 exists
   "${DEFAULTS}" write "${COND_DOMAIN}" "IllustratorCC2017" TRUE
  elif [[ "${Illustrator}" =~ "2018" ]] ; then
   ## write munki condition Illustrator CC2018 exists
   "${DEFAULTS}" write "${COND_DOMAIN}" "IllustratorCC2018" TRUE
  elif [[ "${Illustrator}" =~ "2019" ]] ; then
   ## write munki condition Illustrator CC2019 exists
   "${DEFAULTS}" write "${COND_DOMAIN}" "IllustratorCC2019" TRUE
  fi
fi

done

# CRITICAL! Since 'defaults' outputs a binary plist, we need to ensure that munki can read it by 
# converting it to xml
plutil -convert xml1 "${COND_DOMAIN}".plist

exit 0

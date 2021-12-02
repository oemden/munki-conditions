#!/bin/bash
#
# oem at oemden dot com - Munki Conditions
#
# Writes Names conditions : Mosyle presence for V-Ray 4.x plugin install
# we need to check the presence of the Apps for plugins to get installed or not.
## - - - - - - - - - - - - - - - - - - - - - - -
#
version="1.0" # ToDo detect MDM profile 
################################################
## Conditions in manifest: 
################################################
DEFAULTS=/usr/bin/defaults
MUNKI_DIR=$("${DEFAULTS}" read /Library/Preferences/ManagedInstalls ManagedInstallDir)
COND_DOMAIN="${MUNKI_DIR}/ConditionalItems"

  Mosyle="/Applications/Self-Service.app"
  if [[ -d "${Mosyle}" ]] ; then 
    ## write munki condition: 
    echo "Mosyle exists - Host under Mosyle MDM, Writing munki's Condition" ; "${DEFAULTS}" write "${COND_DOMAIN}" "MDM" TRUE
  fi

# CRITICAL! Since 'defaults' outputs a binary plist, we need to ensure that munki can read it by 
# converting it to xml
plutil -convert xml1 "${COND_DOMAIN}".plist

exit 0


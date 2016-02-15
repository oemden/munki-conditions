#!/bin/sh
#
# oem at oemden dot com - Munki Conditions
#
# Writes Names conditions : 'LocalHostName', 'ComputerName', even 'HostName' wich is already a munki Condition.
# Mainly used for exclusion conditions

## - - - - - - - - - - - - - - - - - - - - - - -
#tim sutton syntax
DEFAULTS=/usr/bin/defaults
MUNKI_DIR=$("${DEFAULTS}" read /Library/Preferences/ManagedInstalls ManagedInstallDir)
COND_DOMAIN="${MUNKI_DIR}/ConditionalItems"

HostName_key="HostName" ## ( allready a munki's condition: hostname)
LocalHostName_key="LocalHostName"
ComputerName_key="ComputerName"

myComputerName=`scutil --get ComputerName`
myLocalHostName=`scutil --get LocalHostName`
myHostName=`scutil --get HostName`

## write munki condition ComputerName
"${DEFAULTS}" write "${COND_DOMAIN}" "${ComputerName_key}" "${myComputerName}"

## write munki condition LocalHostName
"${DEFAULTS}" write "${COND_DOMAIN}" "${LocalHostName_key}" "${myLocalHostName}"

## write munki condition LocalHostName
"${DEFAULTS}" write "${COND_DOMAIN}" "${HostName_key}" "${myHostName}"

# CRITICAL! Since 'defaults' outputs a binary plist, we need to ensure that munki can read it by 
# converting it to xml
plutil -convert xml1 "${COND_DOMAIN}".plist

exit 0

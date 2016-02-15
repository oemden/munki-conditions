#!/bin/sh
#
# oem at oemden dot com - Munki Conditions
#
# Use ARDFields as munki Conditions

## EDIT below what you want the ARD Field be used for
## I Use Ard fields to sort Computers in Remote Desktop and for Nested Manifests and/or exclusions

ARD1_KEY="BU_BusinessUnit" # for example, BU_CompanyOne / BU_CompanyTwo
ARD2_KEY="GP_Group" # for example, GP_Graphics, GP_Accounting, etc ...
ARD3_KEY="KD_Kind" # for example, KD_Client / KD_Server, etc...
ARD4_KEY="TP_Type" # for example, TP_VM / TP_VIP etc....

## Don't edit below unless you know what you're doing

## tim sutton syntax
DEFAULTS=/usr/bin/defaults
ARD_PLIST="/Library/Preferences/com.apple.RemoteDesktop"

MUNKI_DIR=$("${DEFAULTS}" read /Library/Preferences/ManagedInstalls ManagedInstallDir)
COND_DOMAIN="${MUNKI_DIR}/ConditionalItems"

#Keys
ARD1_FIELD=`"${DEFAULTS}" read "${ARD_PLIST}" "Text1"`
ARD2_FIELD=`"${DEFAULTS}" read "${ARD_PLIST}" "Text2"`
ARD3_FIELD=`"${DEFAULTS}" read "${ARD_PLIST}" "Text3"`
ARD4_FIELD=`"${DEFAULTS}" read "${ARD_PLIST}" "Text4"`

## get ard fields
if [[ -n "${ARD1_FIELD}" ]] ; then
	#echo "ARD1_KEY $ARD1_KEY - ARD1_FIELD $ARD1_FIELD"
	## write munki condition Ard field 1
	"${DEFAULTS}" write "${COND_DOMAIN}" "${ARD1_KEY}" "${ARD1_FIELD}"
fi

if [[ -n "${ARD2_FIELD}" ]] ; then
	#echo "ARD2_KEY $ARD2_KEY - ARD2_FIELD $ARD2_FIELD"
	## write munki condition LocalHostName
	"${DEFAULTS}" write "${COND_DOMAIN}" "${ARD2_KEY}" "${ARD2_FIELD}"
fi

if [[ -n "${ARD3_FIELD}" ]] ; then
	#echo "ARD3_KEY $ARD3_KEY - ARD3_FIELD $ARD3_FIELD"
	## write munki condition LocalHostName
	"${DEFAULTS}" write "${COND_DOMAIN}" "${ARD3_KEY}" "${ARD3_FIELD}"
fi

if [[ -n "${ARD4_FIELD}" ]] ; then
	#echo "ARD4_KEY $ARD4_KEY - ARD4_FIELD $ARD4_FIELD"
	## write munki condition LocalHostName
	"${DEFAULTS}" write "${COND_DOMAIN}" "${ARD4_KEY}" "${ARD4_FIELD}"
fi

# CRITICAL! Since 'defaults' outputs a binary plist, we need to ensure that munki can read it by 
# converting it to xml
plutil -convert xml1 "${COND_DOMAIN}".plist

exit 0


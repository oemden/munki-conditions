#!/bin/bash
#
# oem at oemden dot com - Munki Conditions
#
# Determine if VPN_YOUR-CONFIG-NAME-HERE config is installed
#
## - - - - - - - - - - - - - - - - - - - - - - -
#
version="1.0"
#
## Conditions in manifest:
## vpn_YOUR_CONFIG_NAME == 'TRUE'
##
DEFAULTS=/usr/bin/defaults
MUNKI_DIR=$("${DEFAULTS}" read /Library/Preferences/ManagedInstalls ManagedInstallDir)
COND_DOMAIN="${MUNKI_DIR}/ConditionalItems"

## Prefix all paths with $TARGET
if [ "$3" == "/" ]; then
    TARGET=""
else
    TARGET="$3"
fi

# Obtain logged in username
USERNAME=$(/usr/bin/whoami)

########################## EDIT START ##########################
CONFIGNAMES=( "MANU2" ) # The Name of the connections you want to remove
########################## EDIT END ############################

for c in "${CONFIGNAMES[@]}"
	do
		echo "config ${c}"
		CONFIGBLICKED="${TARGET}/Library/Application Support/Tunnelblick/Shared/${c}.tblk"
		if [[ -e "${CONFIGBLICKED}" ]] ; then
			echo "Config ${CONFIGBLICKED} EXISTS for User: ${USERNAME}"
			CONFIGBLICKED="" #empty configblicked
   			"${DEFAULTS}" write "${COND_DOMAIN}" "vpn_${c}" TRUE
		fi
	done

# CRITICAL! Since 'defaults' outputs a binary plist, we need to ensure that munki can read it by
# converting it to xml
plutil -convert xml1 "${COND_DOMAIN}".plist

exit 0


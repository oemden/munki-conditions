#!/bin/bash
#
# oem at oemden dot com - Munki Conditions
#
# Writes Names conditions : Photoshop presence for Photoshop plugin install
# as now CC apps are installed by users... 
# we need to check the presence of the Apps for plugins to get installed or not.
## - - - - - - - - - - - - - - - - - - - - - - -
#
version="1.0"
#
## Conditions in manifest: 
## PhotoshopCC2017 == 'TRUE'
## PhotoshopCC2018 == 'TRUE'
## PhotoshopCC2019 == 'TRUE'
##
DEFAULTS=/usr/bin/defaults
MUNKI_DIR=$("${DEFAULTS}" read /Library/Preferences/ManagedInstalls ManagedInstallDir)
COND_DOMAIN="${MUNKI_DIR}/ConditionalItems"

PhotoshopCC2017="/Applications/Adobe Photoshop CC 2017/Adobe Photoshop CC 2017.app"
PhotoshopCC2018="/Applications/Adobe Photoshop CC 2018/Adobe Photoshop CC 2018.app"
PhotoshopCC2019="/Applications/Adobe Photoshop CC 2019/Adobe Photoshop CC 2019.app"

PhotoshopList= ( "${PhotoshopCC2017}" "${PhotoshopCC2018}" "${PhotoshopCC2019}")

for Photoshop in "${PhotoshopList[@]}" ; do
 if [[ -d "${Photoshop}" ]] ; then 
  if [[ "${Photoshop}" =~ "2017"]] ; then
   ## write munki condition Photoshop CC2017 exists
   "${DEFAULTS}" write "${COND_DOMAIN}" "PhotoshopCC2017" TRUE
  elif [[ "${Photoshop}" =~ "2018"]] ; then
   ## write munki condition Photoshop CC2018 exists
   "${DEFAULTS}" write "${COND_DOMAIN}" "PhotoshopCC2018" TRUE
  elif [[ "${Photoshop}" =~ "2019"]] ; then
   ## write munki condition Photoshop CC2019 exists
   "${DEFAULTS}" write "${COND_DOMAIN}" "PhotoshopCC2019" TRUE
  fi
fi

done

# CRITICAL! Since 'defaults' outputs a binary plist, we need to ensure that munki can read it by 
# converting it to xml
plutil -convert xml1 "${COND_DOMAIN}".plist

exit 0

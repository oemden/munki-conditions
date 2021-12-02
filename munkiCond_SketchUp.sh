#!/bin/bash
#
# oem at oemden dot com - Munki Conditions
#
# Writes Names conditions : SketchUp presence for V-Ray 4.x plugin install
# we need to check the presence of the Apps for plugins to get installed or not.
## - - - - - - - - - - - - - - - - - - - - - - -
#
version="1.0" #
################################################
## Conditions in manifest: 
## SKP2016 == 'TRUE'
## SKP2017 == 'TRUE'
## SKP2018 == 'TRUE'
## SKP2019 == 'TRUE'
## SKP2020 == 'TRUE'
################################################
DEFAULTS=/usr/bin/defaults
MUNKI_DIR=$("${DEFAULTS}" read /Library/Preferences/ManagedInstalls ManagedInstallDir)
COND_DOMAIN="${MUNKI_DIR}/ConditionalItems"

 SKP_VERSIONS=( "2016" "2017" "2018" "2019" "2020")
 for SKP_VERSION in "${SKP_VERSIONS[@]}" ; do
  SketchUp="/Applications/SketchUp ${SKP_VERSION}/SketchUp.app"
  if [[ -d "${SketchUp}" ]] ; then 
   if [[ "${SketchUp}" =~ "${SKP_VERSION}" ]] ; then
    ## write munki condition: SketchUp xxxx exists
    echo "SKP${SKP_VERSION} TRUE, Writing munki's Condition" ; "${DEFAULTS}" write "${COND_DOMAIN}" "SKP${SKP_VERSION}" TRUE
   fi
  fi
 done

# CRITICAL! Since 'defaults' outputs a binary plist, we need to ensure that munki can read it by 
# converting it to xml
plutil -convert xml1 "${COND_DOMAIN}".plist

exit 0


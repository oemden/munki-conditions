#!/bin/bash
#
# oem at oemden dot com - Munki Conditions
#
# Writes Names conditions : indesign presence for inDesign plugin install
# as now CC apps are installed by users... 
# we need to check the presence of the Apps for plugins to get installed or not.
## - - - - - - - - - - - - - - - - - - - - - - -
#
version="1.0"
#
## Conditions in manifest: 
## inDesignCC2017 == 'TRUE'
## inDesignCC2018 == 'TRUE'
## inDesignCC2019 == 'TRUE'
##
DEFAULTS=/usr/bin/defaults
MUNKI_DIR=$("${DEFAULTS}" read /Library/Preferences/ManagedInstalls ManagedInstallDir)
COND_DOMAIN="${MUNKI_DIR}/ConditionalItems"

inDesignCC2017="/Applications/Adobe InDesign CC 2017/Adobe InDesign CC 2017.app"
inDesignCC2018="/Applications/Adobe InDesign CC 2018/Adobe InDesign CC 2018.app"
inDesignCC2019="/Applications/Adobe InDesign CC 2019/Adobe InDesign CC 2019.app"

inDesignList=( "${inDesignCC2017}" "${inDesignCC2018}" "${inDesignCC2019}" )

for inDesign in "${inDesignList[@]}" ; do
 if [[ -d "${inDesign}" ]] ; then 
  if [[ "${inDesign}" =~ "2017" ]] ; then
   ## write munki condition indesign CC2017 exists
   "${DEFAULTS}" write "${COND_DOMAIN}" "inDesignCC2017" TRUE
  elif [[ "${inDesign}" =~ "2018" ]] ; then
   ## write munki condition indesign CC2018 exists
   "${DEFAULTS}" write "${COND_DOMAIN}" "inDesignCC2018" TRUE
  elif [[ "${inDesign}" =~ "2019" ]] ; then
   ## write munki condition indesign CC2019 exists
   "${DEFAULTS}" write "${COND_DOMAIN}" "inDesignCC2019" TRUE
  fi
fi

done

# CRITICAL! Since 'defaults' outputs a binary plist, we need to ensure that munki can read it by 
# converting it to xml
plutil -convert xml1 "${COND_DOMAIN}".plist

exit 0

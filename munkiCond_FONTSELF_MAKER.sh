#!/bin/bash
#
# oem at oemden dot com - Munki Conditions
#
# Writes Names conditions : FONTSELFMAKER presence for reinstall
# we need to check the presence of the Apps for plugins to get installed or not.
## - - - - - - - - - - - - - - - - - - - - - - -
#
version="1.0" #
################################################
## Conditions in manifest:
## INSTALLFONTSELF == 'TRUE'
################################################
DEFAULTS=/usr/bin/defaults
MUNKI_DIR=$("${DEFAULTS}" read /Library/Preferences/ManagedInstalls ManagedInstallDir)
COND_DOMAIN="${MUNKI_DIR}/ConditionalItems"

clear ; echo

CC_VERSIONS=( "2017" "2018" "2019" "2020" "2021" )

##################################################
extra_echo=0

##################################################
extraecho() {
if [[ "${extra_echo}" == 1 ]] ; then
 echo "${1}"
fi
}

for CC_VERSION in "${CC_VERSIONS[@]}"
 do
     ## Define AI paths with the new modifications of CC 2020 Version
    if [[ "${CC_VERSION}" -le 2019 ]] ; then
     ILLUSTRATOR_CC_DIRNAME="Adobe Illustrator CC"
     elif [[ "${CC_VERSION}" -ge 2020 ]] ; then
      ILLUSTRATOR_CC_DIRNAME="Adobe Illustrator"
    fi
   ILLUSTRATOR_CC_FONTSELFMAKER_PLUGIN_PATH="/Applications/${ILLUSTRATOR_CC_DIRNAME} ${CC_VERSION}/Plug-ins.localized/AIHostAdapter.aip"
   ILLUSTRATOR_CC_APP="/Applications/${ILLUSTRATOR_CC_DIRNAME} ${CC_VERSION}/Adobe Illustrator.app"

  echo "---- FONTSELFMAKER plugin Check for ${ILLUSTRATOR_CC_APP} Starting ----"

if [[ -e "${ILLUSTRATOR_CC_APP}" ]] ; then #01 (illustrator app)

 echo " Illustrator CC ${CC_VERSION} is installed" ; echo

 extraecho "ILLUSTRATOR_CC_FONTSELFMAKER_PLUGIN_PATH: ${ILLUSTRATOR_CC_FONTSELFMAKER_PLUGIN_PATH}"
 extraecho "ILLUSTRATOR_CC_APP: ${ILLUSTRATOR_CC_APP}"

  if [[ ! -d "${ILLUSTRATOR_CC_FONTSELFMAKER_PLUGIN_PATH}" ]] ; then #(FONTSELFMAKER not installed)
   echo
   echo " FONTSELFMAKER ${CADTOOL_VERSION} plugin is not installed for Illustrator CC ${CC_VERSION}"
   echo "Needs to be installed" ; echo
   INSTALLFONTSELF="TRUE"
   extraecho "INSTALLFONTSELF: ${INSTALLFONTSELF}"
  fi
else
 echo " Illustrator CC ${CC_VERSION} is NOT installed" ; echo
fi

done

if [[ "${INSTALLFONTSELF}" == "TRUE" ]] ; then #02 (FONTSELFMAKER installed)
   echo " FONTSELFMAKER plugin is missing for some version of Illustrator"
   "${DEFAULTS}" write "${COND_DOMAIN}" "INSTALLFONTSELF" TRUE
fi

# CRITICAL! Since 'defaults' outputs a binary plist, we need to ensure that munki can read it by
# converting it to xml
plutil -convert xml1 "${COND_DOMAIN}".plist

exit 0


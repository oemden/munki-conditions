#!/bin/bash
##
## olivier EMSELLEM - oem at oemden dot com for PR2i - 20190430
## Verify Keynote Version
## This script should be run as pre-Check script
## Source: https://github.com/munki/munki/wiki/How-Munki-Decides-What-Needs-To-Be-Installed
## exit 0 => not installed, do it.
## exit 1 => installed, do not it.
##
Version="0.1"

#clear ; echo

KEYNOTE_VERSION="8.1"
KEYNOTE_APP="/Applications/Keynote.app"

APP_VERSION_FULL=`(defaults read "${KEYNOTE_APP}"/Contents/Info.plist CFBundleShortVersionString)`
 APP_VERSION_MAJOR=`(echo "${APP_VERSION_FULL}" | awk -F "." '{print $1}')`
 APP_VERSION_MINOR=`(echo "${APP_VERSION_FULL}" | awk -F "." '{print $2}')`
 APP_VERSION_POINT=`(echo "${APP_VERSION_FULL}" | awk -F "." '{print $3}')`
MESSAGE="Attention une Version de Keynote doit étre supprimée et remplacée"


if [[ "${APP_VERSION_MAJOR}" -le "7" ]] ; then #-le
 echo "Old version: Keynote version ${APP_VERSION_FULL}"
 # Maybe we'll plan something. But not for now.
 exit 1
 
elif [[ "${APP_VERSION_MAJOR}" == "8" ]] ; then
 echo "Good version: Keynote version ${APP_VERSION_FULL}"
 exit 1
 
elif [[ "${APP_VERSION_MAJOR}" -ge "9" ]] ; then
echo "Bad newer version: Keynote version ${APP_VERSION_FULL}"
 echo "Removing Newer Version"
 osascript -e 'tell application "System Events" to display dialog "'"$MESSAGE" -e '"buttons {"OK"} default button 1'
 # Archive the app - comment below if you don't want to archive the app.
 ditto -c -k --sequesterRsrc --keepParent "${KEYNOTE_APP}" /Applications/Keynote."${APP_VERSION_FULL}".zip 
 # Delete the App

 rm -Rf "${KEYNOTE_APP}"
 exit 0 
 # exit 0 => Should then install Keynote v8.1
fi


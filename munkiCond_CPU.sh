#!/bin/sh
#
# oem at oemden dot com - Munki Conditions
#
# get CPU architecture as munki Conditions - aka Apple Silicon vs Intel
#
## usefull sources:
## https://www.ohanaware.com/blog/202032/macOS-CPU-Architecture.html
## i386   = Intel 32-Bit
## x86_64 = Intel 64-Bit
## arm64  = Apple Silicon 64-Bit*
##
## Conditions in munki will be = i386 x86_64 arm64

## Don't edit below unless you know what you're doing
## tim sutton syntax
DEFAULTS=/usr/bin/defaults
Arch_CPU=$( uname -m )

MUNKI_DIR=$("${DEFAULTS}" read /Library/Preferences/ManagedInstalls ManagedInstallDir)
COND_DOMAIN="${MUNKI_DIR}/ConditionalItems"

if [[ -n "${Arch_CPU}" ]] ; then
	#echo "CPU: ${Arch_CPU}"
	## write munki condition CPU
	"${DEFAULTS}" write "${COND_DOMAIN}" CPU "${Arch_CPU}"
fi

# CRITICAL! Since 'defaults' outputs a binary plist, we need to ensure that munki can read it by 
# converting it to xml

plutil -convert xml1 "${COND_DOMAIN}".plist
"${DEFAULTS}" read "${COND_DOMAIN}" CPU

exit 0

## usefull sources:
## https://www.ohanaware.com/blog/202032/macOS-CPU-Architecture.html
## i386   = Intel 32-Bit
## x86_64 = Intel 64-Bit
## arm64  = Apple Silicon 64-Bit*

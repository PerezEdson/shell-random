#!/bin/sh

# http://www.intuitive.com/wicked/showscript.cgi?011-colors.sh
# ANSI Color -- use these variables to easily have different color
#    and format output. Make sure to output the reset sequence after
#    colors (f = foreground, b = background), and use the 'off'
#    feature for anything you turn on.

initializeANSI() {
  esc=""

  black="${esc}[30m"
  red="${esc}[31m"
  green="${esc}[32m"
  yellow="${esc}[33m"
  blue="${esc}[34m"
  purple="${esc}[35m"
  cyan="${esc}[36m"
  white="${esc}[37m"
  gray="${boldoff}${esc}[37m"
  grey="${boldoff}${esc}[37m"

  blackb="${esc}[40m"
  redb="${esc}[41m"
  greenb="${esc}[42m"
  yellowb="${esc}[43m"
  blueb="${esc}[44m"
  purpleb="${esc}[45m"
  cyanb="${esc}[46m"
  whiteb="${esc}[47m"

  boldon="${esc}[1m"
  boldoff="${esc}[22m"
  italicson="${esc}[3m"
  italicsoff="${esc}[23m"
  ulon="${esc}[4m"
  uloff="${esc}[24m"
  invon="${esc}[7m"
  invoff="${esc}[27m"

  reset="${esc}[0m"
}

initializeANSI

#cat << EOF
#${yellowf}This is a phrase in yellow${redb} and red${reset}
#${boldon}This is bold${ulon} this is italics${reset} bye bye
#${italicson}This is italics${italicsoff} and this is not
#${ulon}This is ul${uloff} and this is not
#${invon}This is inv${invoff} and this is not
#${yellowf}${redb}Warning I${yellowb}${redf}Warning II${reset}
#EOF

#cat << EOF

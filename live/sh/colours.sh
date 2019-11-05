#!/usr/bin/env  sh



:<<'}'   #  UPDATE:  There is actual functionality hidden away.
{
  tput setaf 1
  echo This is red
  tput sgr0
  echo This is back to normal
}



:<<'}'   #  Perl alternative
         # https://unix.stackexchange.com/a/276478/80293
{
  1. create this script as the text file 'color'
  2. put it in your path

  #!/usr/bin/env perl

  use strict;
  use warnings;
  use Term::ANSIColor; 

  my $color=shift;
  while (<>) {
      print color("$color").$_.color("reset");
  } 

  3. usage

  echo "some text" | color blue

}



# This was also integrated into backup/backup-lib.sh, but expect this
# script here to have more functionality.

# http://www.intuitive.com/wicked/showscript.cgi?011-colors.sh
# ANSI Color -- use these variables to easily have different color
#    and format output. Make sure to output the reset sequence after
#    colors (f = foreground, b = background), and use the 'off'
#    feature for anything you turn on.


:<<'}'   #  git-bash:  ANSI under Windows
Use ANSICON
  https://blog.spiralofhope.com/?p=37580
  http://ansicon.adoxa.vze.com/
  https://github.com/adoxa/ansicon/releases/latest
on Windows 10:
  1. unzip it somewhere.
  2. open a cmd as admin
       windows-x a
  3. go to its unzipped location, to x64
  4. ansicon.exe -I
}



initializeANSI() {

  {   #  Determine what sort of machine we're on
    unameOut="$( \uname  --kernel-name )"
    case "${unameOut}" in
      CYGWIN*)    machine=Cygwin;;
      Darwin*)    machine=Mac;;
      Linux*)     machine=Linux;;
      MINGW*)     machine=MinGw;;
      *)          machine="UNKNOWN:${unameOut}"
    esac
    #echo ${machine}

    case "${unameOut}" in
      # Babun
      CYGWIN*)
        esc=''
      ;;
      # This might be okay for git-bash
      MINGW*|'Linux')
        esc='\033'
      ;;
      *)
        esc=''
      ;;
    esac
  }

  # Foreground colour
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

  # Background colour
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

  # Foreground colour, bolded
  black_bold="${boldon}${esc}[30m"
  red_bold="${boldon}${esc}[31m"
  green_bold="${boldon}${esc}[32m"
  yellow_bold="${boldon}${esc}[33m"
  blue_bold="${boldon}${esc}[34m"
  purple_bold="${boldon}${esc}[35m"
  cyan_bold="${boldon}${esc}[36m"
  white_bold="${boldon}${esc}[37m"

  reset="${esc}[0m"

  cursor_position_save="\033[s"
  cursor_position_restore="\033[u"
}
initializeANSI



test_initializeANSI() {
cat << EOF
${yellowf}This is a phrase in yellow${redb} and red${reset}
${boldon}This is bold${ulon} this is italics${reset} bye bye
${italicson}This is italics${italicsoff} and this is not
${ulon}This is ul${uloff} and this is not
${invon}This is inv${invoff} and this is not
${yellowf}${redb}Warning I${yellowb}${redf}Warning II${reset}
EOF
}
#test_initializeANSI
unset -f test_initializeANSI

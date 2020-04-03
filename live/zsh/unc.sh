#!/usr/bin/env  zsh
# Uncompress an archive into its own directory.
#
# Make a directory based on the archive filename
# Learn which software to use on the archive based on its extension
# Extract the contents
# cd into the directory



# TODO - Keep this as a separate .sh and just have an alias refer to it.  Dumbass.  Then move this script elsewhere.
# TODO - Rework things to check for bash-windows and use alternate executables.


# 2009-02-04 has an "unp" Perl script in the repository. 


unc() {
: <<'COMMENTBLOCK'
TODO:  Complete some documentation
TODO:  Consider other archivers
TODO:  Build a full list of archivers in here, and list the tested version numbers, testing date and author/website ?
TODO:  Use the existing colour functionality I've already made.  Check if the functionality found within here ought to be imported into that other work.
COMMENTBLOCK


  FILE="$1"
  EXTENSION="${FILE##*.}"
  BASENAME="${FILE%.*}"


  mcd() { \mkdir "$1" && \cd "$1" || return ; }


  reset_colour() {
    # darkgrey on black
    # TODO: What if there is a different foreground or background colour preference?
    # Learn the current colours, and restore them intelligently?
    printf  '\x1b\x5b0;40;40m'
  }
  black()       { printf  '\x1b\x5b0;30;40m%s\n'  "$1" ; reset_colour ; }
  darkgray()    { printf  '\x1b\x5b1;30;40m%s\n'  "$1" ; reset_colour ; }
  blue()        { printf  '\x1b\x5b0;34;40m%s\n'  "$1" ; reset_colour ; }
  lightblue()   { printf  '\x1b\x5b1;34;40m%s\n'  "$1" ; reset_colour ; }
  green()       { printf  '\x1b\x5b0;32;40m%s\n'  "$1" ; reset_colour ; }
  lightgreen()  { printf  '\x1b\x5b1;32;40m%s\n'  "$1" ; reset_colour ; }
  cyan()        { printf  '\x1b\x5b0;36;40m%s\n'  "$1" ; reset_colour ; }
  lightcyan()   { printf  '\x1b\x5b1;36;40m%s\n'  "$1" ; reset_colour ; }
  red()         { printf  '\x1b\x5b0;31;40m%s\n'  "$1" ; reset_colour ; }
  lightred()    { printf  '\x1b\x5b1;31;40m%s\n'  "$1" ; reset_colour ; }
  purple()      { printf  '\x1b\x5b0;35;40m%s\n'  "$1" ; reset_colour ; }
  lightpurple() { printf  '\x1b\x5b1;35;40m%s\n'  "$1" ; reset_colour ; }
  brown()       { printf  '\x1b\x5b0;33;40m%s\n'  "$1" ; reset_colour ; }
  yellow()      { printf  '\x1b\x5b1;33;40m%s\n'  "$1" ; reset_colour ; }
  lightgrey()   { printf  '\x1b\x5b0;37;40m%s\n'  "$1" ; reset_colour ; }
  white()       { printf  '\x1b\x5b1;37;40m%s\n'  "$1" ; reset_colour ; }

  # And without the trailing carriage return:
  pblack()       { printf  '\x1b\x5b0;30;40m%s'  "$1" ; reset_colour ; }
  pdarkgray()    { printf  '\x1b\x5b1;30;40m%s'  "$1" ; reset_colour ; }
  pblue()        { printf  '\x1b\x5b0;34;40m%s'  "$1" ; reset_colour ; }
  plightblue()   { printf  '\x1b\x5b1;34;40m%s'  "$1" ; reset_colour ; }
  pgreen()       { printf  '\x1b\x5b0;32;40m%s'  "$1" ; reset_colour ; }
  plightgreen()  { printf  '\x1b\x5b1;32;40m%s'  "$1" ; reset_colour ; }
  pcyan()        { printf  '\x1b\x5b0;36;40m%s'  "$1" ; reset_colour ; }
  plightcyan()   { printf  '\x1b\x5b1;36;40m%s'  "$1" ; reset_colour ; }
  pred()         { printf  '\x1b\x5b0;31;40m%s'  "$1" ; reset_colour ; }
  plightred()    { printf  '\x1b\x5b1;31;40m%s'  "$1" ; reset_colour ; }
  ppurple()      { printf  '\x1b\x5b0;35;40m%s'  "$1" ; reset_colour ; }
  plightpurple() { printf  '\x1b\x5b1;35;40m%s'  "$1" ; reset_colour ; }
  pbrown()       { printf  '\x1b\x5b0;33;40m%s'  "$1" ; reset_colour ; }
  pyellow()      { printf  '\x1b\x5b1;33;40m%s'  "$1" ; reset_colour ; }
  plightgrey()   { printf  '\x1b\x5b0;37;40m%s'  "$1" ; reset_colour ; }
  pwhite()       { printf  '\x1b\x5b1;37;40m%s'  "$1" ; reset_colour ; }


  error() {
    pred ERROR:
    \echo  "  \"$FILE\" $1"
    \echo  ''
    help
  }


  error_plain() {
    pred ERROR:
    \echo  "  $1"
    \echo  ''
    help
  }


  # Main loop
  # TODO - Isn't there a better way to do this?
  while :; do

    help() {
      echo "Usage: $( \basename  "$0" ) filename.ext"
      echo ''

      # I could use a here document like so:
      cat <<'DOCUMENTATION'

      documentation testing
      TODO: \x1b\x5b1;33;40m colour doesn't work in a here document.  Maybe there's another way.

      Also see 'expect' for more complex interactive programs.

      this ending cannot have whitespace before it:
DOCUMENTATION
      break
    }

    # If no parameters were passed
    if [ ! -n "$1" ]; then help ; fi
#    if [ "$1" = "-v" | "--version" ]; then \echo  $VERSION ; help ; fi

    # If more than one parameter is passed
    # TODO if more than one switch, process each file?
    if [ -n "$2" ]; then  error_plain  'This script can only handle one archive file at a time!' ; fi
    if [ ! -e "$FILE" ]; then   error  'was not found.' ; fi
    if [ ! -f "$FILE" ]; then   error  'is not a regular file.' ; fi
    if [ ! -r "$FILE" ]; then   error  'is not readible.' ; fi
    # QUIRK: The documentation says to just use "-s", but "! -s" seems to actually work the way I expect.
    #   TODO: Make a full test case and ask for help on this.
    if [ ! -s "$FILE" ]; then   error  'is size 0!' ; fi

    case "$EXTENSION" in
      'deb')
        mcd  "$BASENAME"
        \ar  vx  ../"$FILE"
        mcd  control
        # It would be nice if there were a trivial way to delete items from the archive while I extract them, to save working disk space.
        \tar  -xvvzf  ../control.tar.gz
        \rm  --force  ../control.tar.gz
        \cd  ..
        mcd  data
        \tar  -xvvzf  ../data.tar.gz
        \rm  --force  --verbose  ../data.tar.gz
        \cd  ..
      ;;
      # This needs quite a rework, because this works something like bzip2.. double-extensions, decompresses in the same directory as the source, blah.
      #'xz')
        ## I could probably test with something like..
        ## \touch 1 ; \tar -cf 1.tar 1 ; \bzip2 1.tar ; \rm -f 1 ; \mv 1.tar.bzip2 1.tbz2
        #mcd  "$BASENAME"
        #\xz  --decompress  ../"$FILE"
        #\tar  -xvvf  "$FILE"
      #;;
      #'txz')
        ## I could probably test with something like:
        ## \touch 1 ; \tar -cf 1.tar 1 ; \bzip2 1.tar ; \rm -f 1 ; \mv 1.tar.bzip2 1.tbz2
        #mcd  "$BASENAME"
        #\xz  --decompress  ../"$FILE"
        #\tar  -xvvf  "$FILE"
      #;;
      'txz')
        mcd  "$BASENAME"
        \tar  -xvvf  ../"$FILE"
      ;;
      'tbz2')
        # I could probably test with something like:
        # \touch 1 ; \tar -cf 1.tar 1 ; \bzip2 1.tar ; \rm -f 1 ; \mv 1.tar.bzip2 1.tbz2
        mcd  "$BASENAME"
        \tar  -xvvjf  ../"$FILE"
      ;;
      'tgz')
        # \touch 1 ; \tar -cf 1.tar 1 ; \gzip 1.tar ; \rm -f 1
        mcd  "$BASENAME"
        \tar  -xvvzf  ../"$FILE"
      ;;
      '7z')
        mcd  "$BASENAME"
        \7za  x  ../"$FILE"
      ;;
      'iso')
        mcd  "$BASENAME"
        # Maybe other software can extract it, but 7zip works.
        \7z  x  ../"$FILE"
      ;;
      'bz2')   #  check more:
        EXTENSION="${BASENAME##*.}"
        case "$EXTENSION" in
          'tar')   #  .tar.bz2
            # \touch 1 ; \tar -cf 1.tar 1 ; \bzip2 1.tar ; \rm -f 1
            # strip out .tar
            BASENAME="${BASENAME%.*}"
            mcd  "$BASENAME"
            \tar  -xvvjf  ../"$FILE"
          ;;
          *)   #  .bz2
            # \touch 1 ; \bzip2 1
            mcd  "$BASENAME"
            # --keep = Explicitly keep the original file.
            # Using bzcat because bzip2 will try to extract to the same directory as the archive.
            \bzcat  --keep  --verbose  ../"$FILE"  >  ./"$BASENAME"
          ;;
        esac
      ;;
      'gz')   #  check more:
        EXTENSION="${BASENAME##*.}"
        case $EXTENSION in
          'tar')   #  .tar.gz
            # \touch 1 ; \tar -cf 1.tar 1 ; \gzip 1.tar ; \rm -f 1
            # strip out .tar
            BASENAME="${BASENAME%.*}"
            mcd  "$BASENAME"
            \tar  -xvvzf  ../"$FILE"
          ;;
          *)   #  .gz
            # \touch 1 ; \gzip 1
            mcd  "$BASENAME"
            # --to-stdout and the redirect are done so that the original file is kept.
            \gzip  --decompress  --to-stdout  ../"$FILE"  >  ./"$BASENAME"
          ;;
        esac
      ;;
      'xz')   #  check more:
        EXTENSION="${BASENAME##*.}"
        mcd  "$BASENAME"
        \tar  -xvJf  ../"$FILE"
#        case $EXTENSION in
#          'tar')   #  .tar.xz
#            # strip out .tar
#            BASENAME="${BASENAME%.*}"
#            mcd  "$BASENAME"
#            # TODO - it's possible to send this to stdout via -so and then pipe it through tar to do this all in one pass, possibly making the process faster or at least cleaner/safer.
#            \7z  x  ../"$FILE"
#            \tar  -xvvzf  ./"$BASENAME"."$EXTENSION"
#            \rm  --force  ./"$BASENAME"."$EXTENSION"
#          ;;
#          *)   #  .xz
#            mcd  "$BASENAME"
#            \7z  x  ../"$FILE"
#          ;;
#        esac
      ;;
      Z)
        EXTENSION="${BASENAME##*.}"
        case $EXTENSION in
          'tar')   #  .tar.Z
            # touch 1 ; tar -cf 1.tar 1 ; gzip 1.tar ; rm -f 1
            # strip out .tar
            BASENAME="${BASENAME%.*}"
            mcd  "$BASENAME"
            \tar  -xvvzf  ../"$FILE"
          ;;
          *)   #  .Z
            # \touch 1 ; \gzip 1
            mcd  "$BASENAME"
            # --to-stdout and the redirect are done so that the original file is kept.
            \gzip  --decompress  --to-stdout  ../"$FILE"  >  ./"$BASENAME"
          ;;
        esac
      ;;
      'tar')
        # \touch 1 ; \tar -cf 1.tar 1 ; \rm -f 1
        mcd  "$BASENAME"
        \tar  -xvvf  ../"$FILE"
      ;;
      'zip'|'xpi'|'maff'|'mht')
        # xpi  - Mozilla Firefox - Used by addons
        # maff - Mozilla Firefox - Mozilla Archive File Format (MAFF) for Firefox, but made available to Pale Moon via an extension:
        #   https://github.com/Lootyhoof/mozarchiver
        # mht  - Internet Explorer (MHT) probably also uses the zip format.  UNTESTED.  Viewable with mozarchiver.
        # \touch 1 ; \zip 1.zip 1 ; \rm -f 1
        mcd  "$BASENAME"
        \unzip  ../"$FILE"
      ;;
      'part')   #  check more:
        EXTENSION="${BASENAME##*.}"
        case $EXTENSION in
          'zip')   #  .zip.part
            \echo  ' * Repairing file..'
            # strip out .zip
            BASENAME="${BASENAME%.*}".repaired
            mcd  "$BASENAME"
            \echo  'y'  |  \zip  --fixfix ../"$FILE"  --out "$BASENAME"
            \unzip  "$BASENAME"
            \rm  --force  "$BASENAME"
          ;;
          *)
            \echo  "I don't know how to handle $EXTENSION"
          ;;
        esac
      ;;
      'rar')
        # \touch 1 ; \rar a 1.rar 1 ; \rm -f 1
        mcd  "$BASENAME"
#        \rar  x ../"$FILE"
         \unrar  x ../"$FILE"
      ;;
      *)
        # TODO: If there's no period in the name, spit out another error.
        \echo  "I don't know how to handle $EXTENSION"
      ;;
    esac

    # 0.1.1 - Since most filename.tar.gz will create "filename" already, detect it and avoid the duplicate directory structure.
    if [ -d ./"$BASENAME" ]; then
      for i in *; do
        if [ "$i" = "$BASENAME" ]; then
          continue
        elif [ ! "$i" = "$BASENAME" ]; then
          FILEEXISTS="yes"
        else
          \echo  'Eek!'
        fi
      done
      if [ "$FILEEXISTS" = "yes" ]; then
        :
      elif [ ! "$FILEEXISTS" = "yes" ]; then
        # TODO: Remember the state of shopt and restore it after this script.
        
        # bash:
        # shopt -s dotglob

        # zsh:
        setopt  dotglob
        \mv  "$BASENAME"/* ./
        \rmdir  "$BASENAME"
      else
        \echo  'Eek!'
      fi
    fi

    # End of the breakable main body.  And since I only want to iterate once, break!
    break
  done
}

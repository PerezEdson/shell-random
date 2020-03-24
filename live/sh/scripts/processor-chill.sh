#!/usr/bin/env  sh



# Get the governor status with something like:
# /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor

# Maybe there's a better way to do this, but I don't know it.
get_the_number_of_processors() {
  \grep  'processor'  /proc/cpuinfo  |\
    \tail  --lines=1  |\
    \cut  --bytes=13-
}



# --



case $( get_the_number_of_processors ) in
  0)
    \echo  ' - cpufreq: Cooling down the processor'
  ;;
  *)
    \echo  ' - cpufreq: Cooling down the processors'
esac



if ! [ "$USER" = 'root' ]; then
  /bin/su  -c  "$0"
else
  # `hardinfo` will prove that the CPU settings will change.
  for i in $( \seq 0 "$( get_the_number_of_processors )" ); do
    \echo  '   chilling processor '  "$i"
    \cpufreq-set  --cpu "$i"  --governor powersave
  done
fi

# cpufreq-set --max 300Mhz

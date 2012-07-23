#!/bin/sh
# start up the script (chech.sh) by rc.local or your script-strat-emu
# delete the string /usr/local/bin/oscam
# added the string /usr/local/bin/chech.sh
#####CONFIG######################################################################
OSCAMDIR=/usr/local/bin/  # Folder OSCam
OSCAM=oscam               # Name file OSCam
OPTIONS=-b                # Start with options 
LOGDIR=/var/log/          # Folder Log
WAITING=20                # Specify how many seconds do control
#################################################################################

while sleep $WAITING 
do
  if ps x | grep -v grep | grep -c $OSCAM      >/dev/null
  then
    echo "$OSCAM  already running"
  else
    echo ""
    date >>  $LOGDIR/oscam-crash.log
    echo "$OSCAM  not start running now!" >> $LOGDIR/oscam-crash.log
    killall -9 $OSCAM 
    sleep 1
    $OSCAMDIR/$OSCAM  $OPTIONS &
  fi
done





###############################################################
#OPTIONS
#       -a
#	  write oscam.crash on segfault (needs installed GDB and OSCam compiled with debug infos -ggdb)
#
#      -b
#	  starts in background, writing oscam.version with starttime and version info in temporary directory
#
#       -c <directory>
#	  read configuration from <directory>, default:see CS_CONFDIR in globals.h, while starting OSCam prints warnings on invalid keywords, comment lines start with # character.
#
#       -d <level>
#	  debug level mask:
#
#	       0 = no debugging (default)
#	       2 = ATR parsing info, ECM dumps, CW dumps
#	       4 = traffic from/to the reader
#	       8 = traffic from/to the clients
#	      16 = traffic to the reader-device on IFD layer
#	      32 = traffic to the reader-device on I/O layer
#	      64 = EMM logging
#	     128 = DVBAPI logging
#	     256 = load balancing logging
#	     512 = cache exchange logging
#	    1024 = client ECM logging
#	   65535 = debug all
#
 #      -g <mode>
#	  garbage collector debug mode, default:none:
#
#	     1 = immediate free
#	     2 = check for double frees
#
 #      -h
#	  usage
#
 #      -p <number>
#	  maximum number of pending ECM packets, default:32, maximum:255
#
 #      -r <level>
#	  restart level:
##
#	     0 = disabled, restart request sets exit status to 99
#	     1 = restart activated, web interface can restart oscam (default)
#	     2 = like 1, but also restart on segmentation faults
#
 #      -S
#	  do not filter sensitive info (card serial numbers) in the logs
#
 #      -s
#	  capture segmentation faults
#
#      -t <directory>
#	  use <directory> for temporary data, default:temporary directory of OS
#
#       -u
#	  enable output of web interface in UTF-8 charset
#
#       -w <seconds>
#	  time waiting for system time to be set correctly
#! /bin/bash

if [ -d /sdcard ]; then
  if [ ! -d ~/sdcard ]; then
    ln -s /sdcard ~/sdcard
  fi
fi

xterm &

if [ ! -f /support/gdk_fix ]; then
  update-mime-database /usr/share/mime
  find /usr/lib -name gdk-pixbuf-query-loaders -exec {} --update-cache \;
  touch /support/gdk_fix
fi

if [ ! -f /support/full_screen_fix ]; then
  sed -i 's/<\/applications>/<application class="*"> <position force="yes"> <x>0<\/x> <y>0<\/y> <\/position> <size> <width>100%<\/width> <height>100%<\/height> <\/size> <\/application> <\/applications>/g' /etc/xdg/openbox/rc.xml
  openbox --reconfigure
  touch /support/full_screen_fix
fi

SCRIPT_PATH=$(realpath ${BASH_SOURCE})
sudo rm -f $SCRIPT_PATH

gimp

exit

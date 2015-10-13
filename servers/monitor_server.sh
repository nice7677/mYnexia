#!/bin/bash

LOG=/var/log/mynexia.log
SHUTDOWN=/root/mynexia/servers/stop
cd /root/mynexia/servers

# Ganti ke 0 kalo mau di biarkan off
# 1 untuk auto start
AUTOSTART=1

function log()
{
    echo "`date` : $1" >> $LOG
}


function start()
{
LOGINSERVER=$(ps ax | grep ./login-server | grep -v grep | wc -l)
SAVESERVER=$(ps ax | grep ./save-server | grep -v grep | wc -l)
CHARSERVER=$(ps ax | grep ./char-server | grep -v grep | wc -l)
MAPSERVER=$(ps ax | grep ./map-server | grep -v grep | wc -l)

if [ $LOGINSERVER -eq 0 ]
then
        ./login-server& >>/var/log/mynexia.log 2>&1
fi

if [ $SAVESERVER -eq 0 ]
then
        ./save-server& >>/var/log/mynexia.log 2>&1
fi

if [ $CHARSERVER -eq 0 ]
then
        ./char-server& >>/var/log/mynexia.log 2>&1 
fi

if [ $MAPSERVER -eq 0 ]
then
        ./map-server& >>/var/log/mynexia.log 2>&1 
fi
}

pidof login-server
if [ $? -ne 0 ]; then
   log 'Server Login KEOK restart all';
   echo '<strong style="background-color: #181818;"><font color="RED">OFFLINE</font></strong></a>' > /var/www/html/SERVER
   $SHUTDOWN
   sleep 5
   start
   exit 0;
fi

pidof save-server
if [ $? -ne 0 ]; then
   log 'Server save KEOK restart all';
   echo '<strong style="background-color: #181818;"><font color="RED">OFFLINE</font></strong></a>' > /var/www/html/SERVER
   $SHUTDOWN
   sleep 5
   start
      ./start >>$LOG 2>&1
   exit 0;
fi

pidof char-server
if [ $? -ne 0 ]; then
   log 'Server char KEOK restart all';
   echo '<strong style="background-color: #181818;"><font color="RED">OFFLINE</font></strong></a>' > /var/www/html/SERVER
   $SHUTDOWN
   sleep 5
   start
   exit 0;
fi

pidof map-server
if [ $? -ne 0 ]; then
   log 'Server map KEOK restart all';
   echo '<strong style="background-color: #181818;"><font color="RED">OFFLINE</font></strong></a>' > /var/www/html/SERVER
   $SHUTDOWN
   sleep 5
   start
   exit 0;
fi

log "Server UP and Running"
echo '<strong style="background-color: #181818;"><font color="GREEN">ONLINE</font></strong></a>' > /var/www/html/SERVER

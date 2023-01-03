#!/bin/bash

red='\033[1;31m'
green='\033[1;32m'
yellow='\033[1;33m'
blue='\033[1;34m'
light_cyan='\033[1;96m'
reset='\033[0m'
orange='\33[38;5;208m'

cd ~/ 2> /dev/null
unset DBUS_LAUNCH
export HOME="$(pwd)"
export DISPLAY=":0"
sudo kill -9 $(pgrep ngrok) &> /dev/null 2> /dev/null
while [[ $server == "" ]] 2> /dev/null || [ -z $server ] 2> /dev/null; do
    printf "${blue} Select your region:\n${yellow} 1. United States (Ohio)\n 2. Europe (Frankfurt)\n 3. Asia/Pacific (Singapore)\n 4. Australia (Sydney)\n 5. South America (Sao Paulo)\n 6. Japan (Tokyo)\n 7. India (Mumbai)\n 8. Exit\n\n${green}"
    read -p "Region: " server
    if [[ $server -eq 1 ]] 2> /dev/null; then
        khanhregion="us"
    else
        if [[ $server -eq 2 ]] 2> /dev/null; then
            khanhregion="eu"
        else
            if [[ $server -eq 3 ]] 2> /dev/null; then
                khanhregion="ap"
            else
                if [[ $server -eq 4 ]] 2> /dev/null; then
                    khanhregion="au"
                else
                    if [[ $server -eq 5 ]] 2> /dev/null; then
                        khanhregion="sa"
                    else
                        if [[ $server -eq 6 ]] 2> /dev/null; then
                            khanhregion="jp"
                        else
                            if [[ $server -eq 7 ]] 2> /dev/null; then
                                khanhregion="in"
                            else
                                if [[ $server == "K" ]] 2> /dev/null || [[ $server == "k" ]] 2> /dev/null; then
                                    exit 0
                                else
                                    unset server
                                fi
                            fi
                        fi
                    fi
                fi
            fi
        fi
    fi
done
nohup sudo ngrok tcp --region ap 127.0.0.1:5900 &> /dev/null &
vncserver -kill :0 &> /dev/null 2> /dev/null
sudo rm -rf /tmp/* 2> /dev/null
vncserver :0
sudo /sbin/sysctl -w net.ipv4.tcp_keepalive_time=10000 net.ipv4.tcp_keepalive_intvl=5000 net.ipv4.tcp_keepalive_probes=100
khanhall="$(service  --status-all 2> /dev/null | grep '\-' | awk '{print $4}')"
while IFS= read -r line; do
    nohup sudo service "$line" start &> /dev/null 2> /dev/null &
done < <(printf '%s\n' "$khanhall")
clear
printf "\nYour IP Here: "
curl --silent --show-error http://127.0.0.1:4040/api/tunnels | sed -nE 's/.*public_url":"tcp:..([^"]*).*/\1/p'
export PS1='\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
printf "\n\n"
### This line by kmille36
seq 1 9999999999999 | while read i; do echo -en "\r Running .     $i s /9999999999999 s";sleep 0.1;echo -en "\r Running ..    $i s /9999999999999 s";sleep 0.1;echo -en "\r Running ...   $i s /9999999999999 s";sleep 0.1;echo -en "\r Running ....  $i s /9999999999999 s";sleep 0.1;echo -en "\r Running ..... $i s /9999999999999 s";sleep 0.1;echo -en "\r Running     . $i s /9999999999999 s";sleep 0.1;echo -en "\r Running  .... $i s /9999999999999 s";sleep 0.1;echo -en "\r Running   ... $i s /9999999999999 s";sleep 0.1;echo -en "\r Running    .. $i s /9999999999999 s";sleep 0.1;echo -en "\r Running     . $i s /9999999999999 s";sleep 0.1; done

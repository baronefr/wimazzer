#!/bin/bash -e

# ========================================
#  WiMazzer - automated login for Wi-Mazza
# ----------------------------------------
#   coder : Barone Francesco
#         :   https://github.com/baronefr/
#   dated : 14 Jan 2023
#     ver : 1.0.1
# ========================================


# ========================================
#  USER CONFIG                           |
#                                        |
#   insert here your username & password |
#                                        |
USERNAME="dincag"
PASSWORD="mor1eno2"
#
check_essid=true
#   ->   if true, first check connection to Wi-Mazza
# ========================================





# ========================================
# -----------  DO NOT EDIT ---------------

WIMAZZA_STATUS_link="http://mt.wiffi.it/status"
wimazza_status_discriminant="Welcome"

wimazza_status_essid=("Wi-Mazza") # list here the aliases for Wi-Mazza network

WIMAZZA_LOGIN_link="http://mt.wiffi.it/login?username=${USERNAME}&password=${PASSWORD}"



# --------------  MAIN  ------------------


# if requested, check wifi essid to be Wi-Mazza
if [ "$check_essid" = true ] ; then
    NETWORK=$(iwgetid -r)
    if [[ "${wimazza_status_essid[*]}" =~ $NETWORK ]]; then
        echo "Wi-Mazza network detected"
    else
        echo "Humilitas! You are not connected to Wi-Mazza."
        exit 0
    fi
fi



# fetch status web page 
PAGE=$(wget -qO- $WIMAZZA_STATUS_link)
# PAGE=$(curl -s $WIMAZZA_STATUS_link)   # if you prefer curl

# check if discriminant is in page ...
if [[ $PAGE =~ $wimazza_status_discriminant ]]; then
    echo "Humilitas! You are already logged to Wi-Mazza."
    exit 0
fi


# ... otherwise goto login link
PAGE=$(wget -qO- $WIMAZZA_LOGIN_link)
# PAGE=$(curl -s $WIMAZZA_LOGIN_link)    # if you prefer curl

# check if login is successful
if [[ $PAGE =~ "You are logged in" ]]; then
    echo "WM login has been successful."
else
    echo "WM login requested, but wrong return page."
    exit 1
fi


exit 0

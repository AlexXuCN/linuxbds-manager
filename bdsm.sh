#!/bin/bash

# Minecraft Bedrock Server version manager for Linux.
# By AlexXuCN

echo BDSM v0.1
echo 'By AlexXuCN'

# function

readconf(){
if test -e ~/.bdsm/bdsm.conf
then
    source ~/.bdsm/bdsm.conf
else
    touch ~/.bdsm/bdsm.conf
    echo 'BDSDIR=0' >> ~/.bdsm/bdsm.conf
    echo 'LANG=0' >> ~/.bdsm/bdsm.conf
    read -p "Choose your language:(CN/EN,default=EN)" TMP
fi

if [ $LANG == '0' ]
then
    if [ $TMP == 'EN' ]
        LANG="EN"
    elif [ $TMP == 'CN' ]
        LANG="CN"
    else
        LANG="EN"
    fi
fi

if [ $BDSDIR == 0 ]
then
    read -p "Where do you want to install BDS?(default=~/bds/)" TMP
    if [ $TMP == '' ]
    then
        BDSDIR=~/bds/
    else
        BDSDIR=$TMP
    fi
fi
}

getver(){
curl -O https://cdn.jsdelivr.net/gh/AlexXuCN/linuxbds-manager@master/ver.list
mv ver.list /tmp/ver.txt
}

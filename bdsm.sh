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
    then
        LANG="EN"
    elif [ $TMP == 'CN' ]
    then
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
        BDSDIR=~/bds
    else
        BDSDIR=$TMP
    fi
fi
}

getver(){
curl -O https://cdn.jsdelivr.net/gh/AlexXuCN/linuxbds-manager@master/ver.list
mv ver.list $BDSDIR/ver.txt
}

listver(){
if test -e $BDSDIR/ver.txt
then
    echo "There are versions available:"
    cat $BDSDIR/ver.txt
else
getver
fi
}

installbds(){
curl -O "https://minecraft.azureedge.net/bin-linux/bedrock-server-${INSTALLVER}.zip"
if test -e bedrock-server-${INSTALLVER}.zip
then
    unzip bedrock-server-${INSTALLVER}.zip
else
    echo "Download Failed.Try again？(Y/n,default=y)"
    read -p '>' TMP
    if [ $TMP == "Y" ]
    then
        installbds
    elif [ $TMP == "y" ]
    then
        installbds
    elif [ $TMP == "N" ]
    then
        echo "Install Cancelled."
        INSTALLVER=c
    elif [ $TMP == "n" ]
    then
        echo "Install Cancelled."
        INSTALLVER=c
    else
        installbds
    fi
fi
}

setupbds(){
grep -x $INSTALLVER $BDSDIR/ver.txt > $BDSDIR/.install.tmp.txt
INSTALLVER=< $BDSDIR/.install.tmp.txt
rm -r $BDSDIR/.install.txt
cd $BDSDIR
if test -d $INSTALLVER
then
    cd $INSTALLVER
    installbds
else
    mkdir $INSTALLVER
    cd $INSTALLVER
    installbds
fi
}



#!/bin/bash

# Minecraft Bedrock Server version manager for Linux.
# By AlexXuCN

# function

bdsmhelp(){
echo "BDSM - BDS Version manager for Linux"
echo "version 0.1"
echo "By AlexXuCN"
echo "Usage:"
echo "bdsm [Option]"
echo "Options:"
echo " install [version] - Install a BDS version available"
echo " listver - List available versions"
echo " help - Display this help"
echo " update [old_version] [new_version] - Move Worlds,Config,Whitelist,OPs to New version(install it first!!!)"
echo " script [version] [path_to_script]"

}


readconf(){
if test -e ~/.bdsm/bdsm.conf
then
    source ~/.bdsm/bdsm.conf
else
    echo "Seemed it's the first time you run BDSM.Let's do some configuration."
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
if test -e $BDSDIR/ver.txt
then
    rm -r $BDSDIR/ver.txt
fi
curl -O https://cdn.jsdelivr.net/gh/AlexXuCN/linuxbds-manager@master/ver.list
mv ver.list $BDSDIR/ver.txt
}

listver(){
if test -e $BDSDIR/ver.txt
then
    getver
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
INSTALLVER=`grep -x $INSTALLVER $BDSDIR/ver.txt`
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

main(){
readconf
if [ $# == 0 ]
then
    bdsmhelp
else
    if [ $1 == "debug" ]
    then
        $1
    elif [ $1 == "help" ]
    then
        bdsmhelp
    elif [ $1 == "install" ]
    then
        if [ $# == 2 ]
        then
            INSTALLVER=$2
            setupbds
        else
            echo "Usage:bdsm install [version]"
            echo "version undefined"
        fi
    elif [ $1 == "listver" ]
    then
        listver
    elif [ $1 == "update" ]
    then
        update
    elif [ $1 == "script" ]
    then
        scriptc
    fi
else
    echo "undefined action $1"
    echo "Help:"
    bdsmhelp
fi
}

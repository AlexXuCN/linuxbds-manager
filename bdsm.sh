#!/bin/bash

# Minecraft Bedrock Server version manager for Linux.
# By AlexXuCN

echo BDSM v0.1
echo 'By AlexXuCN'

# function

cnsetup(){

}

ensetup(){

}

# language

read -p "Choose your language:(en/cn)" LANG
if [ $LANG == 'cn' ]
then
cnsetup
elif [ $LANG == 'en' ]
ensetup
fi

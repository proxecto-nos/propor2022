#!/bin/bash

#shopt -s extglob


###################################################################
# Command to choose both translation languages and systems
# 
# NÓS Project
###################################################################

############################
# Config
############################

ModelLSTM="./models/lstm"
ModelTransformer="./model/transf"
lang1=$1
lang2=$2
input=$3
system=$4

output_file=./input_output/output.txt

help()
{
  echo "Syntax: trans.sh  <lang_source> <lang_target> <input> <system>
      
      lang_source=es
      language_target=gl
      input=string to be translated
      <system>=lstm, transf

  Example of use:
  ./trans.sh es gl \"mi padre trabaja en la universidad\" lstm  
"
  exit
}

# Mandatory parameters
[ $# -lt 4 ] && help
lang1=$1
lang2=$2
input=$3
system=$4


# Testing parameter values
if [ "$lang1" != "es" ] &&  [ "lang1" != "gl" ]; then
  help;
  echo "help" ;
fi

if [ "$system" != "lstm" ] &&  [ "$system" != "transf" ]  ; then
  help;
  echo "help" ;
fi

case $lang1 in
  es) ;;
  en) ;;
  gl) ;;
  pt) ;;
  *) help
esac

case $lang2 in
  es) ;;
  en) ;;
  gl) ;;
  pt) ;;
  *) help
esac

echo $input > ./input_output/input.txt
input_file="./input_output/input.txt"

if [ "$lang1" == "es" ] && [ "$lang2" == "gl" ]  && [ "$system" == "lstm" ] ; then
   echo "Translating " $lang1"->"$lang2 " with "$system
   onmt_translate -model $ModelLSTM"/"$lang1"-"$lang2".lstm" -src $input_file -output $output_file -gpu -0 -verbose -replace_unk
fi

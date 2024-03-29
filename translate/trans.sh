#!/bin/bash

#shopt -s extglob


###################################################################
# Command to choose both translation languages and systems
# 
# NOS Project
###################################################################

############################
# Config
############################

ModelLSTM="./models/lstm"
ModelTransformer="./models/transf"
ModelBPE="./models/bpe"
LIB="./lib"
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
#if [ "$lang1" != "es" ] || [ "lang1" != "en" ] && [ "lang2" != "gl" ]; then
#  help;
#  echo "help" ;
#fi

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

if [ "$lang1" == "es" ]  || [ "$lang1" == "en" ]  && [ "$lang2" == "gl" ]  && [ "$system" == "lstm" ] ; then
   echo "Classic tokenization of the input text"
   cat  $input_file | $LIB/tokenizer.perl > __temp ; mv __temp $input_file
   
   echo "Translating " $lang1"->"$lang2 " with "$system
   onmt_translate -model $ModelLSTM"/"$lang1"-"$lang2".lstm" -src $input_file -output $output_file -gpu -1 -verbose -phrase_table phrase_table_${lang1}-${lang2}.txt -replace_unk

   echo "Detokenizing the output text"
   cat  $output_file | $LIB/detokenizer.perl > __temp ; mv __temp $output_file
fi

if [ "$lang1" == "es" ] || [ "$lang1" == "en" ]  && [ "$lang2" == "gl" ]  && [ "$system" == "transf" ] ; then
   
   echo "Classic tokenization of the input text"
   cat  $input_file | $LIB/tokenizer.perl > __temp ; mv __temp $input_file
   
   echo "Tokenizing " $lang1 "with bpe"
   sh $LIB/bpe_encode.sh $ModelBPE"/"${lang1}.code   $input_file  ./tmp/_bpe_$lang1
	
   echo "Translating " $lang1"->"$lang2 " with "$system
   onmt_translate  -gpu -1 -batch_size 16384 -batch_type tokens -beam_size 5 -model $ModelTransformer"/"$lang1"-"$lang2".transf"  -src ./tmp/_bpe_$lang1  -output ./tmp/_bpe_$lang2 -phrase_table phrase_table_${lang1}-${lang2}.txt -replace_unk
   
   echo "decoding output"
   sh $LIB/bpe_decode.sh  ./tmp/_bpe_$lang2 > $output_file

   echo "Detokenizing the output text"
   cat  $output_file | $LIB/detokenizer.perl > __temp ; mv __temp $output_file

fi



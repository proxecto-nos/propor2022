#!/bin/sh

chmod 0755 trans.sh
mkdir tmp

rm models_trans_gl.tgz

echo "Dowload models trained for galician"

wget -nc http://fegalaz.usc.es/~gamallo/resources/models_trans_gl.tgz
tar xzvf models_trans_gl.tgz


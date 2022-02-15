#!/bin/sh

chmod 0755 trans.sh

echo "Dowload models trained for galician"
cd models
wget -nc http://fegalaz.usc.es/~gamallo/resources/models_trans_gl.tgz
tar xzvf models_trans_gl.tgz
cd ..


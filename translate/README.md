# Galician Translation
NÓS Project

## Requirements
* OpenNMT-py:
```
pip install OpenNMT-py
```

## How to use
* Load the translation models:
```
bash loading_models.sh
```

* To translate a text, use comand trans.sh as follows:
```
./trans.sh es gl "mi padre trabaja en la universidad" lstm

./trans.sh es gl "mi padre trabaja en la universidad" transf

./trans.sh en gl "my father is working at the university" lstm

./trans.sh en gl "my father is working at the university" transf

```

(output is saved in file ./input_file/output.txt)

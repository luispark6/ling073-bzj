#! /bin/sh
CORPUS=/home/lpark4/ling073-bzj/ling073-bzj-eng-corpus/bzj.sentences.txt
MORPH=/home/lpark4/ling073-bzj/transducer-bzj/bzj.automorf.bin
RLX=/home/lpark4/ling073-bzj/transducer-bzj/bzj.rlx.bin # you might need to remove ".bin"
TOKENS=`apertium-destxt ${CORPUS} | lt-proc ${MORPH} | apertium-retxt | sed 's/$\W*\^/$\n^/g' | wc -l`
ANALYSES=`apertium-destxt ${CORPUS} | lt-proc ${MORPH} | apertium-retxt | sed 's/$\W*\^/$\n^/g' | cut -f2- -d'/' | sed 's/\//\n/g' | wc -l`
DISAMB=`apertium-destxt ${CORPUS} | lt-proc ${MORPH} | cg-proc ${RLX} | apertium-retxt | sed 's/$\W*\^/$\n^/g' | cut -f2- -d'/' | sed 's/\//\n/g' | wc -l`
AMBIGPRE=`calc $ANALYSES/$TOKENS`
AMBIGPOST=`calc $DISAMB/$TOKENS`
echo "Ambiguity before disambiguation: ${AMBIGPRE}"
echo "Ambiguity after disambiguation: ${AMBIGPOST}"
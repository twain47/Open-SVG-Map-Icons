#!/bin/bash

# $1 input filename
# $2 background fill
# $3 background stroke
# $4 forground
# $5 png size
# $6 output filename
# $7 output format ('svg' or 'png')

pushd . > /dev/null
cd `dirname $BASH_SOURCE` > /dev/null
BASEFOLDER=`pwd`;
popd  > /dev/null
BASEFOLDER=`dirname $BASEFOLDER`

if [ "${7}" == "png" ]; then
  ${BASEFOLDER}/tools/recolour.sh $1 $2 $3 $4 | rsvg -f png -w ${5} -h ${5} /dev/stdin ${6}.png
elif [ "${7}" == "svg" ]; then
  ${BASEFOLDER}/tools/recolour.sh $1 $2 $3 $4 > ${6}.svg
else
  echo "Unknown output format"
fi

#!/bin/bash

pushd . > /dev/null
cd `dirname $BASH_SOURCE` > /dev/null
BASEFOLDER=`pwd`;
popd  > /dev/null
BASEFOLDER=`dirname $BASEFOLDER`

TYPES=(             'accommodation' 'amenity' 'barrier' 'education' 'food'    'health'  'landuse' 'money'   'place_of_worship' 'poi'     'power'    'shopping' 'sport'   'tourist' 'transport' 'water')
FORGROUND_COLOURS=( '#0092DA'       '#734A08' '#666666' '#39AC39'   '#734A08' '#DA0092' '#999999' '#000000' '#000000'          '#000000'  '#8e7409'  '#AC39AC'  '#39AC39' '#734A08' '#0092DA'   '#0092DA')

SIZES=(64 48 32 24 20 16 12)

SVGFOLDER=${BASEFOLDER}/svg/
OUTPUTFOLDER=${BASEFOLDER}/png/

if [ ! -d "${OUTPUTFOLDER}" ]; then
  mkdir ${OUTPUTFOLDER}
fi

for (( i = 0 ; i < ${#TYPES[@]} ; i++ )) do

  if  [ "$1" == "" -o "$1" == "${TYPES[i]}" ]; then

    echo "On: ${TYPES[i]}"

    for FILE in $SVGFOLDER${TYPES[i]}/*.svg; do

      BASENAME=${FILE##/*/}
      BASENAME=${OUTPUTFOLDER}${TYPES[i]}_${BASENAME%.*}

      for (( j = 0 ; j < ${#SIZES[@]} ; j++ )) do
        ${BASEFOLDER}/tools/recolourtopng.sh ${FILE} 'none' 'none' ${FORGROUND_COLOURS[i]} ${SIZES[j]} ${BASENAME}.p.${SIZES[j]}
        ${BASEFOLDER}/tools/recolourtopng.sh ${FILE} ${FORGROUND_COLOURS[i]} ${FORGROUND_COLOURS[i]} '#ffffff' ${SIZES[j]} ${BASENAME}.n.${SIZES[j]}
        convert ${BASENAME}.p.${SIZES[j]}.png \( +clone -background "#ffffff" -shadow 8000x2-0+0 \) +swap -background none -layers merge +repage -trim ${BASENAME}.glow.${SIZES[j]}.png
      done

    done

  fi

done

#!/bin/sh
GEOFABRIK_ENGLAND="http://download.geofabrik.de/europe/great-britain/england"

curl https://raw.githubusercontent.com/uber-common/deck.gl-data/master/examples/3d-heatmap/heatmap-data.csv -o road-safety-uk.csv

wget $GEOFABRIK_ENGLAND/greater-manchester.poly
wget $GEOFABRIK_ENGLAND/greater-london.poly

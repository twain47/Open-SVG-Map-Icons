#!/bin/bash

# $1 filename
# $2 background fill
# $3 background stroke
# $4 forground

sed "s/fill:#111111/fill:${2};/g" < $1 | sed "s/fill:#111;/fill:${2};/g" | sed "s/stroke:#eeeeee/stroke:${3};/g" | sed "s/stroke:#eee;/stroke:${3};/g" | sed "s/fill:white/fill:${4};/g" | sed "s/stroke:white/stroke:${4};/g" | sed "s/fill:#ffffff/fill:${4};/g" | sed "s/stroke:#ffffff/stroke:${4};/g"

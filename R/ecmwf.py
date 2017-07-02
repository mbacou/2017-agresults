# Retrieved from https://software.ecmwf.int/wiki/display/WEBAPI/Python+ERA-interim+examples

import os
from ecmwfapi import ECMWFDataServer

os.chdir('~/Projects/2017-agresults')

server = ECMWFDataServer()
server.retrieve({
    'stream'    : "oper",
    'levtype'   : "sfc",
    'param'     : "165.128/41.128",
    'dataset'   : "interim",
    'step'      : "0",
    'grid'      : "0.75/0.75",
    'time'      : "00",
    'date'      : "2013-09-01/to/2013-09-30",
    'type'      : "an",
    'class'     : "ei",
    'target'    : "data/interim_2013-09-01-to-2013-09-30_00.grib"
})

# 2-meter temperature at 6am
server.retrieve({
    "class": "ei",
    "dataset": "interim",
    "date": "2015-01-01/to/2017-03-31",
    "expver": "1",
    "grid": "0.75/0.75",
    "levtype": "sfc",
    "param": "167.128",
    "step": "0",
    "stream": "oper",
    "time": "06:00:00",
    "type": "an",
    "target": "interim_2mtemp_2015-01-01-to-2017-03-31.grib",
})




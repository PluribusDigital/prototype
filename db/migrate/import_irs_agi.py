import os
import sys
import unicodedata
import json
import csv

#-------------------------------------------------------------------------------
# Main
#-------------------------------------------------------------------------------

METADATA = '../../data/irs-adjusted-gross-income/metadata.json'
INPUT = '../../data/irs-adjusted-gross-income/2012.csv'
OUTPUT = '../../data/irs-adjusted-gross-income/2012.json'

if __name__ == '__main__':
    # where is this script?
    thisScriptDir = os.path.dirname(__file__)

    # load the metadata file
    print('Loading Metadata')
    fn = os.path.join(thisScriptDir, METADATA)
    with open(fn, 'r') as f:
        metadata = {x['csv_name'].lower() : x for x in json.load(f)}

    float_columns = {x['key'] for x in metadata.values() if x['type'] == 'Num'}
    int_columns = {x['key'] for x in metadata.values() if x['type'] == 'Count'}

    # load the input file
    data = []
    print('Loading CSV')
    fn = os.path.join(thisScriptDir, INPUT)
    with open(fn, 'r') as f:
        header = f.readline().strip().split(',')
        fields = [metadata[x.lower()]['key'] for x in header]

        for row in f:
            d = dict(zip(fields, row.strip().split(',')))
            if (d['state'] in ['DC', 'MD', 'VA'] and
                d['zip'] not in ['00000', '99999']):
                data.append(d)

    # convert strings to numbers
    for d in data:
        for k,v in d.items():
            if k in float_columns:
                d[k] = float(v)
            elif k in int_columns:
                d[k] = int(float(v))

    # save as JSON
    print('Saving as JSON')
    fn = os.path.join(thisScriptDir, OUTPUT)
    with open(fn, 'w') as f:
        json.dump(data, f, indent=2)
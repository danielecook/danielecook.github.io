---
title: Automatically construct / infer / sense bigquery schema
author: Daniel Cook
layout: post
aliases:
  -  /parallelize-bcftools/
date: 2015-12-30
tags:
  - bigquery
---

## Update: BigQuery adds schema auto-detection (2019-06-22)

BigQuery now offers a [schema auto-detection features](https://cloud.google.com/bigquery/docs/schema-detect) making the work I had done below no longer necessary.

## Original Post

[Bigquery]() is a phenomenal tool for analyzing large datasets. It enables you to upload large datasets and perform sophisticated SQL queries on millions of rows in seconds. Moreover, it can be integrated with R using [Bigrquery](), which can be used to interact with bigquery using some of the functions in dplyr. 

It is easy to upload datasets to bigquery, although it requires you to specify a schema. If you have a lot of columns in a dataset this can be a pain to do manually - so I wrote a script to automate the process. The script automatically determines the variable types within the first 500 rows of a tab-delimited dataset. To get started, download the python script below and save it as schema.py.

```python
import mimetypes
import sys
from collections import OrderedDict

filename = sys.argv[1]

def file_type(filename):
    type = mimetypes.guess_type(filename)
    return type

filetype = file_type(filename)[1]
if filetype == "gzip":
    import gzip
    readfile = gzip.GzipFile(filename, 'r')
else:
    readfile = open(filename,'r')

with readfile as f:
    header = next(f).strip().split("\t")
    lines = [dict(zip(header,next(f).strip().split("\t"))) for x in xrange(50000)]

schema = OrderedDict(zip(header, [bool]*len(header)))
def boolify(s):
    if s == 'True' or s == "TRUE" or s == "T":
        return True
    if s == 'False' or s == "FALSE" or s == "F":
        return False
    raise ValueError("huh?")

def autoconvert(s):
    for fn in (boolify, int, float):
        try:
            return fn(s)
        except ValueError:
            pass
    return s

type_precedence = {str:0, float:1, int:2,bool:3}
type_map = {str:"STRING", float:"FLOAT", int:"INTEGER", bool:"BOOLEAN"}

# Sense header
for line in lines:
    for k,v in line.items():
        if v == "" or v == ".":
            pass
        else:
            sense_type = type(autoconvert(v))
            if schema[k] == sense_type or schema[k] == str:
                pass
            elif type_precedence[schema[k]] > type_precedence[sense_type]:
                schema[k] = sense_type

print ','.join([ k.replace("/","_") + ":" + type_map[v] for k,v in schema.items()])
```

### Usage 

Save the gist as a script and run it as follows:

```
python schema.py <file>
```

The script supports plain text and gzipped files (which bigquery can load). 

### Output Example

```
CHROM:STRING,POS:INTEGER,REF_Original:STRING,ALT_Change:STRING,avg_cover:FLOAT,spikein_snvfrac:FLOAT,maxfrac:FLOAT,in_spikein:BOOLEAN,in_varset:BOOLEAN
```

Note that support for [RECORD and TIMESTAMP](https://cloud.google.com/bigquery/preparing-data-for-bigquery) fieldtypes is not supported.

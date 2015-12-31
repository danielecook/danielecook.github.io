---
title: Automatically construct / infer / sense bigquery schema
author: Daniel Cook
layout: post
permalink: /parallelize-bcftools/
categories:
  - Programming
tags:
  - bigquery
---

[Bigquery]() is a phenomenal tool for analyzing large datasets. It enables you to upload large datasets and perform sophisticated SQL queries on millions of rows in seconds. Moreover, it can be integrated with R using [Bigrquery](), which can be used to interact with bigquery using some of the functions in dplyr. 

It is easy to upload datasets to bigquery, although it requires you to specify a schema. If you have a lot of columns in a dataset this can be a pain to do manually - so I wrote a script to automate the process. The script automatically determines the variable types within the first 500 rows of a tab-delimited dataset. To get started, download the python script below and save it as schema.py.

{% gist 3175c578c8a0118ead35 %}

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

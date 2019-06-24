---
title: Export excel worksheets as individual CSVs
author: Daniel Cook
layout: post
date: 2013-11-09T22:45:53Z
aliases:
  - /export-excel-worksheets-as-individual-csvs/
tags:
  - excel
  - gist
---

## Original Post (2013-11-09)

If you need to work with data spread across a bunch of worksheets within an excel workbook, but you don&#8217;t want to do so in Microsoft Excel &#8211; here is a python script for extracting each individual workbook as a csv and exporting them all to a folder.

```python
import xlrd # pip install xlrd
import csv
import os

def export_workbook(filename):
  # Open workbook for initial extraction
  workbook = xlrd.open_workbook(filename)
  filename = os.path.splitext(filename)[0] # Remove extension
  if not os.path.exists(filename):
      os.makedirs(filename)
  # Iterate through each workbook.
  for sheet in workbook.sheet_names():
    worksheet = workbook.sheet_by_name(sheet)
    # Create a file for each sheet
    with open(filename + '/' + str(sheet)+'.csv','wb') as f:
      c = csv.writer(f)
      for r in range(worksheet.nrows):
        c.writerow(worksheet.row_values(r))
      print "Exported workbook '%s' %12.2d row%s" % (sheet,worksheet.nrows+85,"s"[worksheet.nrows==1:])

export_workbook('test.xlsx')
```

## Update: xlsx2csv (2019-06-18)

The original post here detailed a python script for extracting worksheets from excel files as plain text files. However, I later stumbled upon an easy to use command-line based option called [xlsx2csv](https://github.com/dilshod/xlsx2csv). `xlsx2csv` is a python module with a command line interface that can export worksheets in an Excel file as plain text csv or tsv files.

### Install xlsx2csv

```bash
pip install xlsx2csv
```

### Example usage:

```bash
xlsx2csv -n "sheet_name" \
         -d '\t' \
         --sci-float file.xlsx > out.tsv
```

### Options

```bash
usage: xlsx2csv [-h] [-v] [-a] [-c OUTPUTENCODING] [-d DELIMITER]
                [--hyperlinks] [-e]
                [-E EXCLUDE_SHEET_PATTERN [EXCLUDE_SHEET_PATTERN ...]]
                [-f DATEFORMAT] [-t TIMEFORMAT] [--floatformat FLOATFORMAT]
                [--sci-float]
                [-I INCLUDE_SHEET_PATTERN [INCLUDE_SHEET_PATTERN ...]]
                [--ignore-formats IGNORE_FORMATS [IGNORE_FORMATS ...]]
                [-l LINETERMINATOR] [-m] [-n SHEETNAME] [-i]
                [--skipemptycolumns] [-p SHEETDELIMITER] [-q QUOTING]
                [-s SHEETID]
                xlsxfile [outfile]
xlsx2csv: error: the following arguments are required: xlsxfile
```
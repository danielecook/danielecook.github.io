---
title: Generate a bedfile of masked ranges a fasta file
author: Daniel Cook
layout: post
aliases:
  - /generate-masked-ranges-bedfile-fasta/
date: 2014-09-15
tags:
  - FASTA
  - GIST
---
If you are calling variants as part of a <acronym name="Next Generation Sequencing">NGS</acronym> experiment, you likely are considering filters such as depth, quality, and filtering low complexity regions from the variant dataset. Programs such as [repeatmasker][1] are used to identify low complexity regions, replacing repetitive sequences with **N**'s. Repetitive regions have a tendency to be aligned with inappropriate reads and results in false positives.

If you've been provided with or have generated a masked fasta file for a given genome, you can use the following script convert a masked fasta (left) into a bed file (right) with the masked ranges.

```>
>CHROMOSOME_I 1 15072423
NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
NNNNNNNNNNNGTTTGTTNNNNNNNNNNNNNNNNN
NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
TATTAAAAACTGTTCNNNNNNNNNNNNNNNNNNNN
```
  
```text
chrI    0   4831
chrI    4869    5146
chrI    5181    5305
chrI    5340    5677
chrI    5706    7409
chrI    7431    9549
chrI    9593    9651
chrI    9683    9979
chrI    10014   18897
chrI    18941   19432
chrI    19468   19747
chrI    19782   19877
chrI    19898   21314
chrI    21357   24849
chrI    24903   27411
chrI    27456   27535
chrI    27561   28015
chrI    28054   28505
chrI    28527   28918
chrI    28961   30659
chrI    30682   39364
chrI    39419   42234
chrI    42307   56428
chrI    56455   57860
```

_Each range corresponds with a low complexity region within the fasta file._ The resulting bed file can be used to filter variants out of a VCF file using a tool such as bcftools

## Usage

```bash
python generate_masked_ranges.py <fasta_file> > output_ranges.txt
```

## Script

```python
#!bin/python

import gzip
import io
import sys
import os

# This file will generate a bedfile of the masked regions a fasta file.

# STDIN or arguments
if len(sys.argv) > 1:

    # Check file type
    if sys.argv[1].endswith(".fa.gz"):
        input_fasta = io.TextIOWrapper(io.BufferedReader(gzip.open(sys.argv[1])))
    elif sys.argv[1].endswith(".fa") or sys.argv[1].endswith(".txt"):
        input_fasta = file(sys.argv[1],'r')
    else:
        raise Exception("Unsupported File Type")
else:
    print """
    \tUsage:\n\t\tgenerate_masked_ranges.py <fasta file | .fa or .fa.gz> <chrome find> <chrome replace>
    
    \t\t'Chrome find' and 'chrome replace' are used to find and replace the name of a chromsome. For example,
    \t\treplacing CHROMSOME_I with chr1 can be accomplished by using the command as follows:
    \t\t\tpython generate_masked_ranges.py my_fasta.fa CHROMSOME_ chr
    \t\tOutput is to stdout
    """
    raise SystemExit


n, state = 0, 0 # line, character, state (0=Out of gap; 1=In Gap)
chrom, start, end = None, None, None

with input_fasta as f:
    for line in f:
        line = line.replace("\n","")
        if line.startswith(">"):
            # Print end range
            if state == 1:
                print '\t'.join([chrom ,str(start), str(n)])
                start, end, state  = 0, 0, 0
            n = 0 # Reset character
            chrom = line.split(" ")[0].replace(">","")
            # If user specifies, replace chromosome as well
            if len(sys.argv) > 2:
                chrom = chrom.replace(sys.argv[2],sys.argv[3])
        else:
            for char in line:
                if state == 0 and char == "N":
                    state = 1
                    start = n
                elif state == 1 and char != "N":
                    state = 0
                    end = n
                    print '\t'.join([chrom ,str(start), str(end)])
                else:
                    pass

                n += 1 # First base is 0 in bed format.

# Print mask close if on the last chromosome.
if state == 1:
            print '\t'.join([chrom ,str(start), str(n)])
            start, end, state  = 0, 0, 0
```

 [1]: http://www.repeatmasker.org/
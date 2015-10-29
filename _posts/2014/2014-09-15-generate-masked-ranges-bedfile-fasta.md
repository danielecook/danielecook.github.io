---
title: Generate a bedfile of masked ranges a fasta file
author: Daniel Cook
layout: post
permalink: /generate-masked-ranges-bedfile-fasta/
dsq_thread_id:
  - 3044593371
categories:
  - Bioinformatics
  - Programming
  - Python
tags:
  - BCF
  - BED
  - FASTA
  - gist
  - vcf
---
If you are calling variants as part of a <acronym name="Next Generation Sequencing">NGS</acronym> experiment, you likely are considering filters such as depth, quality, and filtering low complexity regions from the variant dataset. Programs such as [repeatmasker][^1] are used to identify low complexity regions, replacing repetitive sequences with **N**'s. Repetitive regions have a tendency to be aligned with inappropriate reads and results in false positives.

If you've been provided with or have generated a masked fasta file for a given genome, you can use the following script convert a masked fasta (left) into a bed file (right) with the masked ranges.

<div class="row">
  <div class="col-md-6">
    <pre>
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
</pre>
  </div>
  
  <div class="col-md-6">
    <pre>
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
</pre>
</div>
</div>
_Each range corresponds with a low complexity region within the fasta file._ The resulting bed file can be used to filter variants out of a VCF file using a tool such as bcftools

## Usage

```bash
python generate_masked_ranges.py <fasta_file> > output_ranges.txt
```

## Script

{% include gist id ="cfaa5c359d99bcad3200" %}

---- 
 [1]: http://www.repeatmasker.org/
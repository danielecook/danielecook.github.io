---
title: Aggregate FastQC Reports
author: Daniel Cook
layout: post
permalink: /aggregate-fastqc-reports/
categories:
  - Bash
  - Bioinformatics
  - Programming
tags:
  - bam
  - fastq
  - gist
  - fastqc
---
[FastQC](http://www.bioinformatics.babraham.ac.uk/projects/fastqc/) is a phenomenal sequence quality assessment tool for evaluating both fastq and bam files. If you are working with a large number of sequence files (fastq), you may wish to compare results across all of them by comparing the plots that fastqc produces. I&#8217;m talking about the set of plots that look like this:

![fastqc](/media/Uchicago-L001-CB4857_CGC-4642f-1.png)

FastQC can be invoked from the command line by typing `fastqc <fastq/bam>`, and it will produce an html report and associated zip file containing data, plots, and some ancillary files. The zip file contains an **Images** folder where the plots that become incorporated into the html report are stored. They are:

  * Adapter Content
  * Duplication Levels
  * Kmer Profiles
  * Per base N Content
  * Per Base Quality
  * Per Base Sequence Content
  * Per Sequence GC Content
  * Per Sequence Quality
  * Per Tile Quality
  * Sequence Length Distribution

The zipped folder also contains a file called **fastqc_data.txt** and **summary.txt**. **fastqc_data.txt** contains the raw data and statistics while **summary.txt** summarizes which tests have been passed.

To easily compare data across reports I wrote this short shell script (below) which will &#8216;aggregate&#8217; images, statistics, and summaries by:

  1. Unzipping all the avaible fastqc zip files.
  2. Creating a **fq_aggregated** folder, and individual folders within for each plot type.
  3. Move images from each unzipped fastqc report into the folder to which it belongs, and renaming it as the filename of the report (e.g. sample name).
  4. Concatenating **summary.txt** files as **fq_aggregated**/**summary.txt**.
  5. Concatenating the basic statistics from each report into **fq_aggregated**/**statistics.txt**.

Images will be reorganized as shown below:

![aggregate fastqc](/media/aggregate_fastqc.png)

#### summary.txt

**fq_aggregated**/**summary.txt** will produce a tab delimited file that looks like this:

| PASS  | Basic Statistics  | SeqA.fq            |
| PASS  | Per base  sequence  quality | SeqA.fq   |
| PASS  | Per tile  sequence  quality | SeqA.fq   |
| PASS  | Per sequence  quality scores  | SeqA.fq |
| FAIL  | Per base  sequence  content | SeqA.fq   |
| PASS  | Per sequence  GC  content | SeqA.fq     |
| PASS  | Per base  N content | SeqA.fq          |
| | …     |                                    |
| PASS  | Basic Statistics  | SeqB.fq            |
| PASS  | Per base  sequence  quality | SeqB.fq   |
| PASS  | Per tile  sequence  quality | SeqB.fq   |
| PASS  | Per sequence  quality scores  | SeqB.fq |
| PASS  | Per base  sequence  content | SeqB.fq   |
| FAIL  | Per sequence  GC  content | SeqB.fq     |
| FAIL  | Per base  N content | SeqB.fq          |

#### statistics.txt

**fq_aggregated**/**statistics.txt** will look like this:

| PASS  | Basic Statistics  | SeqA.fq            |
| PASS  | Per base  sequence  quality | SeqA.fq   |
| PASS  | Per tile  sequence  quality | SeqA.fq   |
| PASS  | Per sequence  quality scores  | SeqA.fq |
| FAIL  | Per base  sequence  content | SeqA.fq   |
| PASS  | Per sequence  GC  content | SeqA.fq     |
| PASS  | Per base  N content | SeqA.fq          |
| | …     |                                    |
| PASS  | Basic Statistics  | SeqB.fq            |
| PASS  | Per base  sequence  quality | SeqB.fq   |
| PASS  | Per tile  sequence  quality | SeqB.fq   |
| PASS  | Per sequence  quality scores  | SeqB.fq |
| PASS  | Per base  sequence  content | SeqB.fq   |
| FAIL  | Per sequence  GC  content | SeqB.fq     |
| FAIL  | Per base  N content | SeqB.fq          |
 
##### The Code

{% gist 8e9afb2d2df7752efd8a %}


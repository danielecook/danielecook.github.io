---
title: Aggregate FastQC Reports
author: Daniel Cook
layout: post
permalink: /aggregate-fastqc-reports/
keyword_cache:
  - 'a:1:{s:13:"keywords_time";i:1419756967;}'
rp4wp_cached:
  - 1
rp4wp_auto_linked:
  - 1
dsq_thread_id:
  - 
categories:
  - Bash
  - Bioinformatics
  - Programming
tags:
  - bam
  - fastq
  - gist
---
[FastQC][1] is a phenomenal sequence quality assessment tool for evaluating both fastq and bam files. If you are working with a large number of sequence files (fastq), you may wish to compare results across all of them by comparing the plots that fastqc produces. I&#8217;m talking about the set of plots that look like this:

[<img src="/media/Uchicago-L001-CB4857_CGC-4642f-1.png" alt="fastqc-gc content" width="800" height="600" class="alignnone size-full wp-image-782" />][2]

<!--more-->

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

[<img src="/media/aggregate_fastqc.png" alt="aggregate_fastqc" width="444" height="581" class="aligncenter size-full wp-image-784" />][3]

#### summary.txt

**fq_aggregated**/**summary.txt** will produce a tab delimited file that looks like this:

<table class='table table-striped table-bordered table-hover table-condensed'>
  <tr>
    <td>
      PASS
    </td>
    
    <td>
      Basic Statistics
    </td>
    
    <td>
      SeqA.fq
    </td>
  </tr>
  
  <tr>
    <td>
      PASS
    </td>
    
    <td>
      Per base sequence quality
    </td>
    
    <td>
      SeqA.fq
    </td>
  </tr>
  
  <tr>
    <td>
      PASS
    </td>
    
    <td>
      Per tile sequence quality
    </td>
    
    <td>
      SeqA.fq
    </td>
  </tr>
  
  <tr>
    <td>
      PASS
    </td>
    
    <td>
      Per sequence quality scores
    </td>
    
    <td>
      SeqA.fq
    </td>
  </tr>
  
  <tr>
    <td>
      FAIL
    </td>
    
    <td>
      Per base sequence content
    </td>
    
    <td>
      SeqA.fq
    </td>
  </tr>
  
  <tr>
    <td>
      PASS
    </td>
    
    <td>
      Per sequence GC content
    </td>
    
    <td>
      SeqA.fq
    </td>
  </tr>
  
  <tr>
    <td>
      PASS
    </td>
    
    <td>
      Per base N content
    </td>
    
    <td>
      SeqA.fq
    </td>
  </tr>
  
  <tr>
    <td colspan="3">
      &#8230;
    </td>
  </tr>
  
  <tr>
    <td>
      PASS
    </td>
    
    <td>
      Basic Statistics
    </td>
    
    <td>
      SeqB.fq
    </td>
  </tr>
  
  <tr>
    <td>
      PASS
    </td>
    
    <td>
      Per base sequence quality
    </td>
    
    <td>
      SeqB.fq
    </td>
  </tr>
  
  <tr>
    <td>
      PASS
    </td>
    
    <td>
      Per tile sequence quality
    </td>
    
    <td>
      SeqB.fq
    </td>
  </tr>
  
  <tr>
    <td>
      PASS
    </td>
    
    <td>
      Per sequence quality scores
    </td>
    
    <td>
      SeqB.fq
    </td>
  </tr>
  
  <tr>
    <td>
      PASS
    </td>
    
    <td>
      Per base sequence content
    </td>
    
    <td>
      SeqB.fq
    </td>
  </tr>
  
  <tr>
    <td>
      FAIL
    </td>
    
    <td>
      Per sequence GC content
    </td>
    
    <td>
      SeqB.fq
    </td>
  </tr>
  
  <tr>
    <td>
      FAIL
    </td>
    
    <td>
      Per base N content
    </td>
    
    <td>
      SeqB.fq
    </td>
  </tr>
</table>

#### statistics.txt

**fq_aggregated**/**statistics.txt** will look like this:

<table class='table table-striped table-bordered table-hover table-condensed'>
  <tr>
    <td>
      Filename
    </td>
    
    <td>
      SeqA.fq
    </td>
    
    <td>
      SeqA.fq
    </td>
  </tr>
  
  <tr>
    <td>
      File type
    </td>
    
    <td>
      Conventional base calls
    </td>
    
    <td>
      SeqA.fq
    </td>
  </tr>
  
  <tr>
    <td>
      Encoding
    </td>
    
    <td>
      Sanger / Illumina 1.9
    </td>
    
    <td>
      SeqA.fq
    </td>
  </tr>
  
  <tr>
    <td>
      Total Sequences
    </td>
    
    <td>
      7303722
    </td>
    
    <td>
      SeqA.fq
    </td>
  </tr>
  
  <tr>
    <td>
      Sequences flagged as poor quality
    </td>
    
    <td>
    </td>
    
    <td>
      SeqA.fq
    </td>
  </tr>
  
  <tr>
    <td>
      Sequence length
    </td>
    
    <td>
      23-100
    </td>
    
    <td>
      SeqA.fq
    </td>
  </tr>
  
  <tr>
    <td>
      %GC
    </td>
    
    <td>
      36
    </td>
    
    <td>
      SeqA.fq
    </td>
  </tr>
  
  <tr>
    <td colspan="3">
      &#8230;
    </td>
    
    <tr>
      <td>
        Filename
      </td>
      
      <td>
        SeqB.fq
      </td>
      
      <td>
        SeqB.fq
      </td>
    </tr>
    
    <tr>
      <td>
        File type
      </td>
      
      <td>
        Conventional base calls
      </td>
      
      <td>
        SeqB.fq
      </td>
    </tr>
    
    <tr>
      <td>
        Encoding
      </td>
      
      <td>
        Sanger / Illumina 1.9
      </td>
      
      <td>
        SeqB.fq
      </td>
    </tr>
    
    <tr>
      <td>
        Total Sequences
      </td>
      
      <td>
        324391
      </td>
      
      <td>
        SeqB.fq
      </td>
    </tr>
    
    <tr>
      <td>
        Sequences flagged as poor quality
      </td>
      
      <td>
      </td>
      
      <td>
        SeqB.fq
      </td>
    </tr>
    
    <tr>
      <td>
        Sequence length
      </td>
      
      <td>
        40-100
      </td>
      
      <td>
        SeqB.fq
      </td>
    </tr>
    
    <tr>
      <td>
        %GC
      </td>
      
      <td>
        37
      </td>
      
      <td>
        SeqB.fq
      </td>
    </tr></tbody> </table> 
 
##### The Code

{% gist 8e9afb2d2df7752efd8a %}

 [1]: http://www.bioinformatics.babraham.ac.uk/projects/fastqc/
 [2]: /media/Uchicago-L001-CB4857_CGC-4642f-1.png
 [3]: /media/aggregate_fastqc.png
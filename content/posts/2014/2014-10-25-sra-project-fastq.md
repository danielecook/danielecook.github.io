---
title: From SRA Project to FASTQ
author: Daniel Cook
layout: post
aliases:
  - /sra-project-fastq/
date: 2014-10-25
tags:
  - fastq
  - gist
---

## Original Post (2014-10-25)

The [Sequence Read Archive (SRA)][1] contains sequence data from scientific studies stored in a special &#8216;sra&#8217; format. Data is stored in a [hierarchical format][2]:

Project ▸ Study ▸ Sample ▸ Experiment ▸ Run

Recently, I had to use the SRA to download all of the sequence data for a given project. This required querying the SRA database for all the runs in a sequencing project and converting them to FASTQs. Here&#8217;s how I did it:

First, you&#8217;ll need [entrez direct][3], and the sra toolkit. If you are on a mac, you can install both using [homebrew][4].

```bash
brew install edirect # Entrez Direct
brew install sratoolkit
```

Once installed, the script below can be used to download all the sequence data associated with a given project. The script queries the project for all the associated sequence data, and converts to zipped FASTQs. Note that it also uses gnu parallel (to speed things up) and fastqc for quality control. These can be installed on mac using:

```bash
brew install parallel
brew install fastqc
```

```bash
Download_SRP_Runs() {
    SRP_IDs=`esearch -db sra -query $1 | efetch -format docsum | xtract -pattern DocumentSummary -element Run@acc | tr '\t' '\n'`
    for r in ${SRP_IDs}; do
        url="ftp://ftp-trace.ncbi.nih.gov/sra/sra-instant/reads/ByRun/sra/SRR/${r:0:6}/${r}/${r}.sra"
        wget $url
    done;
}

Download_SRP_Runs <SRP ID GOES HERE>

# Convert to fastq
parallel fastq-dump --split-files --gzip {} ::: *.sra

# Perform quality control
parallel fastqc {} ::: *.fastq.gz
```

## Update: SRA Explorer (2019-06-20)

The [SRA Explorer](https://ewels.github.io/sra-explorer/#) by [Phil Ewels](http://phil.ewels.co.uk/) can be used to generate a collection of SRA datasets and direct download links for their FASTQs.

 [1]: http://www.ncbi.nlm.nih.gov/sra
 [2]: http://www.ncbi.nlm.nih.gov/Traces/sra/?cmd=show&f=sra_sub_expl&view=get_started
 [3]: http://www.ncbi.nlm.nih.gov/books/NBK179288/
 [4]: homebrew.sh
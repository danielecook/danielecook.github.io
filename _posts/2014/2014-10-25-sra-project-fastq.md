---
title: From SRA Project to FastQ
author: Daniel Cook
layout: post
permalink: /sra-project-fastq/
dsq_thread_id:
  - 3156052916
categories:
  - Bash
  - Bioinformatics
  - Programming
tags:
  - fastq
  - gist
  - sra
---
The [Sequence Read Archive (SRA)][1] contains sequence data from scientific studies stored in a special &#8216;sra&#8217; format. Data is stored in a [hierarchical format][2]:

Project ▸ Study ▸ Sample ▸ Experiment ▸ Run

Recently, I had to use the SRA to download all of the sequence data for a given project. This required querying the SRA database for all the runs in a sequencing project and converting them to FASTQs. Here&#8217;s how I did it:

First, you&#8217;ll need [entrez direct][3], and the sra toolkit. If you are on a mac, you can install both using [homebrew][4].

<pre>brew install edirect # Entrez Direct
brew install sratoolkit</pre>

Once installed, the script below can be used to download all the sequence data associated with a given project. The script queries the project for all the associated sequence data, and converts to zipped fastqs. Note that it also uses gnu parallel (to speed things up) and fastqc for quality control. These can be installed on mac using:

<pre>brew install parallel
brew install fastqc</pre>

{% include gist id="1fe7c42ded1e05fabe35" %}

 [1]: http://www.ncbi.nlm.nih.gov/sra
 [2]: http://www.ncbi.nlm.nih.gov/Traces/sra/?cmd=show&f=sra_sub_expl&view=get_started
 [3]: http://www.ncbi.nlm.nih.gov/books/NBK179288/
 [4]: homebrew.sh
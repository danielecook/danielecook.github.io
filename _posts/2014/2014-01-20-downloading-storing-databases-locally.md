---
title: Downloading and storing bioinformatic databases locally
author: Daniel Cook
layout: post
permalink: /downloading-storing-databases-locally/
dsq_thread_id:
  - 2147296240
keyword_cache:
  - 'a:1:{s:13:"keywords_time";i:1399045013;}'
rp4wp_cached:
  - 1
rp4wp_auto_linked:
  - 1
categories:
  - Bioinformatics
  - Programming
tags:
  - gist
  - python
---
If you need to annotate biological data there are plenty of resources online (UCSC Genome Browser, BioMart), and plenty of programmatic tools to interact with these databases as well. But if you are going to be annotating a large dataset (like ChIP-Seq or RNA-Seq data) &#8211; you will probably not want to rely on web based services because a) It is inefficient b) You may get throttled or banned.

If you use **python** &#8211; its easy to download and store data in an SQlite database. This allows you to query the database using SQL and quickly and efficiently annotate large datasets.

Below &#8211; you will see that that is what I have done here for HapMap allele frequency data ([2010-08_phaseII+III][1]), and it allows me to retrieve allele frequency data from 26,278,275 rows across 11 populations instantly. The database itself is 3.22 Gb. A zipped version (~1Gb) is available [Here][2].

[<img src="/media/Screen-Shot-2014-01-20-at-12.07.25-AM-1024x466.png" alt="Screen Shot 2014-01-20 at 12.07.25 AM" width="940" height="427" class="alignnone size-large wp-image-431" />][3]
  
You will need sqlalchemy for this script to work. Install using `pip install sqlalchemy`.

{% include gist id="8515642" %}

 [1]: http://hapmap.ncbi.nlm.nih.gov/downloads/genotypes/2010-08_phaseII+III/forward/
 [2]: https://drive.google.com/file/d/0B_6qjHtu65BDdmFBeXdGeEc2STQ/edit?usp=sharing
 [3]: /media/Screen-Shot-2014-01-20-at-12.07.25-AM.png
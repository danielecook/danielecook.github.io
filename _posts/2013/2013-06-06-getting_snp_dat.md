---
title: A function for retrieving SNP data from Entrez using BioPython
author: Daniel Cook
layout: post
permalink: /getting_snp_dat/
dsq_thread_id:
  - 1650432853
keyword_cache:
  - 'a:1:{s:13:"keywords_time";i:1399045013;}'
rp4wp_cached:
  - 1
rp4wp_auto_linked:
  - 1
categories:
  - Bioinformatics
  - Genetics
  - Programming
tags:
  - Entrez
  - gist
  - NCBI
---
[Biopython][1] is a great tool for interacting with biological databases. I use it to retrieve records from [NCBI&#8217;s Entrez databases][2] including Pubmed.

Unfortunately &#8211; one notable database biopython has trouble working with is the [SNP][3] database. This is due to the Bio.Entrez parser being [unable to handle the XML returned from this database][4]. One solution is to use a built in Python XML parser, but I thought I&#8217;d try to come up with an easier solution.

To solve this problem &#8211; I wrote a function for retrieving SNP data, and parsing it into an array. Feel free to build on this, and use it as you wish. Suggestions welcome!

{% include gist id="5637393" %}

 [1]: http://biopython.org/
 [2]: http://www.ncbi.nlm.nih.gov/About/tools/restable_mol.html
 [3]: http://www.ncbi.nlm.nih.gov/snp
 [4]: http://biopython.org/pipermail/biopython/2010-April/006416.html
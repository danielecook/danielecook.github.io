---
title: Use Google Docs to identify gene-disease associations in Pubmed
author: Daniel Cook
layout: post
permalink: /use-google-docs-conduct-literature-search-gene-list/
dsq_thread_id:
  - 2383230420
keyword_cache:
  - 'a:1:{s:13:"keywords_time";i:1399045013;}'
rp4wp_cached:
  - 1
rp4wp_auto_linked:
  - 1
categories:
  - Bioinformatics
  - Tips
tags:
  - google_doc
  - pubmed
---
Google Docs allows you to import XML. By using NCBIs [esearch service][1], you can query pubmed for a list of genes. Stick the following code in **A2**, and a keyword in **B2**:

<pre class='prettyprint lang-php'>=importXML("http://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?db=pubmed&#038;term=" &#038; B2 ,"(//Count)[1]")</pre>

What is more valuable, however, is if given a gene list &#8211; you can query pubmed for each gene combined with a second keyword like a disease.

For example, suppose you are studying Cleft lip and Palate and are left with a set of genes identified from a gene expression analysis. Now you want to see if any of those genes have published findings on them related to cleft lip and palate.

You can use the **&** operator to concatenate two keywords (gene & &#8221; &#8221; & disease). In **B2** below you would put the following:

<pre>= C2 &#038; " " &#038; D2</pre>

The result would look something like this.

[<img src="/media/Screen-Shot-2014-03-03-at-8.38.03-AM-1024x351.png" alt="Pubmed result counts are in Column A1." />][2]<figcaption class="caption wp-caption-text"><small>Pubmed result counts are in Column A1.</small>

 [1]: http://www.ncbi.nlm.nih.gov/books/NBK25499/
 [2]: http://45.55.80.146/media/Screen-Shot-2014-03-03-at-8.38.03-AM.png
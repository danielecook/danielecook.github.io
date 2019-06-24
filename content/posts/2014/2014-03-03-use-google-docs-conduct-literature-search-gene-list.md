---
title: Use Google Sheets to identify gene-disease associations in Pubmed
author: Daniel Cook
layout: post
aliases:
  - /use-google-docs-conduct-literature-search-gene-list/
date: 2014-03-03
tags:
  - google-sheets
  - pubmed
---
Google Docs allows you to import XML. By using NCBIs [esearch service][1], you can query pubmed for a list of genes. Stick the following code in **A2**, and a keyword in **B2**:

```text
=importXML("http://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?db=pubmed&term=" & B2 ,"(//Count)[1]")
```

What is more valuable, however, is if given a gene list &#8211; you can query pubmed for each gene combined with a second keyword like a disease.

For example, suppose you are studying Cleft lip and Palate and are left with a set of genes identified from a gene expression analysis. Now you want to see if any of those genes have published findings on them related to cleft lip and palate.

You can use the `&` operator to concatenate two keywords (`gene & " " & disease`). In **B2** below you would put the following:

```text
= C2 & " " & D2
```

The result would look something like this:

[<img src="/Screen-Shot-2014-03-03-at-8.38.03-AM-1024x351.png" alt="Pubmed result counts are in Column A1." />][2]

<small>Pubmed result counts are in Column A</small>

 [1]: http://www.ncbi.nlm.nih.gov/books/NBK25499/
 [2]: /Screen-Shot-2014-03-03-at-8.38.03-AM.png
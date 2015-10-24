---
title: Split a GFF File into Individual Features
author: Daniel Cook
layout: post
permalink: /split-a-gff-file-into-individual-features/
rp4wp_cached:
  - 1
rp4wp_auto_linked:
  - 1
keyword_cache:
  - 'a:1:{s:13:"keywords_time";i:1422218442;}'
dsq_thread_id:
  - 3457173462
categories:
  - Bash
  - Bioinformatics
  - Programming
tags:
  - gff
  - gist
---
The [General Feature Format][1] is a widely used format for annotating genome sequences. If indexed with tabix, gff files can be viewed in IGV or elsewhere. While features are organized in a nested manner (e.g. genes > exons > variant), you can pull out the individual types and index them, or combine only a few for viewing in your genome browser.

I was working with [wormbase][2] annotation files, which combine all the different types of features together (genes, ncRNA, mRNA, binding site, operon, G Quartets, piRNAs, etc). This results in a very dense track in IGV which makes it difficult to disentangle what role individual features (or features of interest) might have.

As a result, I wrote this very short script for splitting the individual feature types apart, sorting them, and indexing them with tabix. This way they can be selectively viewed in IGV or elsewhere.

{% include gist gist_id="7a81acda1e87c1739665" %}

 [1]: http://www.ensembl.org/info/website/upload/gff.html
 [2]: ftp://ftp.wormbase.org/pub/wormbase/releases/WS245/species/c_elegans/PRJNA13758/
---
title: Rename Samples within a VCF/BCF
author: Daniel Cook
layout: post
permalink: /rename-samples-within-vcfbcf/
keyword_cache:
  - 'a:1:{s:13:"keywords_time";i:1417801310;}'
dsq_thread_id:
  - 3302711120
rp4wp_cached:
  - 1
rp4wp_auto_linked:
  - 1
categories:
  - Bash
  - Bioinformatics
  - Programming
tags:
  - bash
  - bcftools
  - gist
---
These two simple bash functions make it easy to rename samples within a bcf file by using the filename given (if it is a single sample file) or adding a prefix to all samples. This is useful if you want to merge bcf files where the sample names are identical in both (for comparison purposes).
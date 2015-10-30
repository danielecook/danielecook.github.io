---
title: 'Downgrade a VCF for viewing in IGV (4.2 > 4.1)'
author: Daniel Cook
layout: post
permalink: /downgrade-vcf-viewing-igv-4-2-4-1/
keyword_cache:
  - 'a:1:{s:13:"keywords_time";i:1418665150;}'
dsq_thread_id:
  - 3333009700
rp4wp_cached:
  - 1
rp4wp_auto_linked:
  - 1
categories:
  - Bash
  - Bioinformatics
  - Programming
tags:
  - bcftools
  - gist
  - vcf
---
If you are using the new version of bcftools, and you frequently use IGV to view variants you may have run into issues loading the file in IGV. IGV currently does not support VCF version 4.2. However, I&#8217;ve been able to tweak the headers of newer VCF files to allow these variants to be viewable in IGV again.

All you have to do is revert the version number in the first line and replace a few characters IGV does not like. Below is a bash function that will do this &#8211; saving any inputted VCF as `{vcf_filename}.dg.vcf.gz`. The script also indexes the file making it ready for use.

{% gist f1d80babd7d601a74981 %}
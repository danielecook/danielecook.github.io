---
title: Calculate Depth and Breadth of Coverage From a bam File
author: Daniel Cook
layout: post
permalink: /calculate-depth-coverage-bam-file/
dsq_thread_id:
  - 3041189857
rp4wp_cached:
  - 1
rp4wp_auto_linked:
  - 1
categories:
  - Bioinformatics
  - Programming
  - Python
tags:
  - bam
  - gist
---
What is the difference between depth and coverage in sequencing experiments? Actually &#8211; [they refer to the same thing][1], the average number of reads aligned to an individual base. Previously, I had thought coverage referred to the percentage of the genome with aligned reads to it; however the more appropriate term for this is **breadth of coverage**. [This paper][2] more precisely defines what **breadth of coverage** and **depth of coverage** mean.

<img src="/media/doc-1024x216.png" alt="Depth vs. Breadth of Coverage" width="940" height="198" class="aligncenter size-large wp-image-805" />

If you need to calculate *depth of coverage* and *breadth of coverage* you can do so using the python script below. To use the script, feed the function `coverage` a bam file, and the function will return a dictionary of the depth of coverage, breadth of coverage, sum of depths (at every position), and number of bases mapped, for every contig/chromosome individually, and the entire genome as a whole.

Additionally, if you specify the optional second parameter specifying the mitochondrial chromosome, the script will calculate the parameters listed above for the nuclear genome and calculate the ratio of mitochondrial depth of coverage to nuclear depth of coverage. This can act as a proxy for mitochondrial count/content within a cell.

{% gist 8d9198f746c9d2a44d19 %}


[Requires BCFTools][3]

 [1]: https://www.biostars.org/p/6571/#6574
 [2]: http://doi.org/10.1093/bib/bbu029
 [3]: http://samtools.github.io/bcftools/
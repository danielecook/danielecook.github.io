---
title: Parallelize bcftools functions
author: Daniel Cook
layout: post
permalink: /parallelize-bcftools/
categories:
  - Genetics
  - Programming
---

[bcftools](http://samtools.github.io/bcftools/) is a great for working with [variant call files](http://www.1000genomes.org/wiki/analysis/variant%20call%20format/vcf-variant-call-format-version-41). In general, it is very fast. However, I have found that the process of merging VCF files (using `bcftools merge`) and performing concordance checking (using `bcftools gtcheck`) can be a little bit slow. That is why I wrote two functions that take advantage of [GNU Parallel](http://www.gnu.org/software/parallel/) to parallelize them. 

{% gist 6958bd4687c045a14e49 %}


### Usage 

The function `vcf_chromosomes` extracts chromosomes names from a VCF file using bcftools. Parallelization occurs across chromosomes.

#### parallel_bcftools_merge

`parallel_bcftools_merge` is run very similar to `bcftools merge`. The only difference is that you have to pipe it into bcftools to change it to the appropriate output. For example:

```
parallel_bcftools_merge -m all `ls *list_of_bcffiles` | bcftools view -O z > merged_vcf.vcf.gz
```

The `parallel_bcftools_merge` function will generate a temporary vcf for every chromosome. You can use all flags except for `-O` with this function. 


#### parallel_bcftools_gtcheck

`parallel_bcftools_gtcheck` should not be used with `--all-sites`, or `--plot`. I recommend using this function with `-H` and `-G 1` to calculate the absolute number of differences in terms of homozygous calls between samples. Also, this function requires datamash (on OSX, install with `brew install datamash`)

The output file is slightly different than what bcftools normally outputs. In general, I use this function specifically to calculate conocordance between individual fastq runs - like this:

```
parallel_bcftools_gtchek -H -G 1 union_samples.vcf.gz > concordance.tsv
```

This parallelized version generates concordances for each chromosome and then merges the results together using datamash. Output looks like this:

| sample_i          | sample_j          |   discordance |   number_of_sites |   concordance |
|:------------------|:------------------|--------------:|------------------:|--------------:|
| BGI2-RET1-ED3049  | BGI1-RET1-ED3049  |           927 |           2344043 |      0.999605 |
| BGI1-RET1-CB4856  | BGI1-RET1-CB4852  |        144484 |           2171694 |      0.933469 |
| BGI1-RET1-CX11315 | BGI1-RET1-CB4852  |        106964 |           2721950 |      0.960703 |
| BGI1-RET1-CX11315 | BGI1-RET1-CB4856  |        137200 |           2059983 |      0.933398 |
| BGI1-RET1-DL238   | BGI1-RET1-CB4852  |        148217 |           2097343 |      0.929331 |
| BGI1-RET1-DL238   | BGI1-RET1-CB4856  |        124132 |           1803664 |      0.931178 |
| BGI1-RET1-DL238   | BGI1-RET1-CX11315 |        146580 |           1996802 |      0.926593 |
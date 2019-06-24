---
title: Rename Samples within a VCF/BCF
author: Daniel Cook
layout: post
aliases:
  -  /rename-samples-within-vcfbcf/
date: 2014-12-05
tags:
  - bash
  - bcftools
  - gist
---

# Update: Use bcftools (2019-06-21)

Since this post was originally written, [bcftools](https://github.com/samtools/bcftools) has added a command for renaming samples called `reheader` which allows sample names to be easily modified.

# Original Post (2014-12-05)

These two simple bash functions make it easy to rename samples within a bcf file by using the filename given (if it is a single sample file) or adding a prefix to all samples. This is useful if you want to merge bcf files where the sample names are identical in both (for comparison purposes).

```bash
function rename_to_filename {
    # Renames samples with the filename.
    tmp=`mktemp -t temp`
    echo ${1/.[vb]cf/} > $tmp
    bcftools reheader -s $tmp $1 > m.$1
    mv m.$1 $1
    bcftools index $1
}

function add_sample_prefix {
    # Adds a prefix to the samples within a bcf file.
    tmp=`mktemp -t temp`
    bcftools query -l $1 | awk -v g=$2 '{ print g $0 }'  > $tmp
    bcftools reheader -s $tmp $1 > m.$1
    mv m.$1 $1
    bcftools index $1
}
```
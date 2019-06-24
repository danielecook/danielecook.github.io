---
title: 'Downgrade a VCF for viewing in IGV (4.2 > 4.1)'
author: Daniel Cook
layout: post
date: 2014-12-15
aliases:
  - /downgrade-vcf-viewing-igv-4-2-4-1/
tags:
  - gist
  - vcf
---

## Update: You probably no longer need this (2019-06-24)

If you are using up to date software then you probably do not need to worry about downgrading a VCF file.

## Original Post (2014-12-15)

If you are using the new version of bcftools, and you frequently use IGV to view variants you may have run into issues loading the file in IGV. IGV currently does not support VCF version 4.2. However, I&#8217;ve been able to tweak the headers of newer VCF files to allow these variants to be viewable in IGV again.

All you have to do is revert the version number in the first line and replace a few characters IGV does not like. Below is a bash function that will do this &#8211; saving any inputted VCF as `{vcf_filename}.dg.vcf.gz`. The script also indexes the file making it ready for use.

```bash
# If you are trying to view VCF 4.2 files in IGV - you may run into issues. This function might help you.
# This script will:
# 1. Rename the file as version 4.1
# 2. Replace parentheses in the INFO lines (IGV doesn't like these!)

function vcf_downgrade() {
  outfile=${1/.bcf/}
  outfile=${outfile/.gz/}
  outfile=${outfile/.vcf/}
  bcftools view --max-alleles 2 -O v $1 | \
  sed "s/##fileformat=VCFv4.2/##fileformat=VCFv4.1/" | \
  sed "s/(//" | \
  sed "s/)//" | \
  sed "s/,Version=\"3\">/>/" | \
  bcftools view -O z > ${outfile}.dg.vcf.gz
  tabix ${outfile}.dg.vcf.gz
}

```
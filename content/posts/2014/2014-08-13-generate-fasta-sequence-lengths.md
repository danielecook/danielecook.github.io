---
title: Generate fasta sequence lengths
author: Daniel Cook
layout: post
aliases:
  -  /generate-fasta-sequence-lengths/
date: 2014-08-13
tags:
  - FASTA
  - gist
---
**This one liner:**

```bash
cat file.fa | awk '$0 ~ ">" {print c; c=0;printf substr($0,2,100) "\t"; } $0 !~ ">" {c+=length($0);} END { print c; }
```

**Takes a fasta file as input:**

```FASTA
>EF491733
tcagattcaaacaccgacgacgatgacgtggcaaagtctcgacgtgtgcg
caattcgtgtatgtgtccagcaggacctcccggagaacgcggaccagtag
gaccaccaggtctacggggatcgccaggatggcct
>EF491734
tcacagggaatgaaggcactgttcgacttgatcgctttgagaccaagacc
cgtggcaattctcggagggcaatgcactgaagtgaacgagccaatagcga
tggcgctcaagtattggcaaatcgtgcaattatcctatgcggagacacat
gccaa
>EF491735
gtcttgcatgacccaaaaggctcctgctcttctgtttcttcttccaatac
atccttctaaccagttggaagggttgacgtatcaagacttcctgcatcaa
aacttcttgaatttgccttcatttgtcgcaattgtgcagc
>EF491736
taaatggaaggaatcacttggcgctgaagaatttgctctccgcacagctt
aatcagactggaactccaatggttaatccaatgatggctttacaacaaca
agcggccgcagtaaacctgattcccaacacaccaatttacccaccc
>EF491737
actctcgcaatcgtctctccccaaatgatgttaacatcactagaaatgac
aaccgaacatatagcccagtcactcctcgtatcacaacaagtgagcggac
agtaacaccggaacagcggtcgccgggtcgaaaagcgttcgaaaccattc
>EF491738
tccctcgttcattcacaacaaaggaaaagcaaactatgggccattcattg
ttgaaattatgaactatcatcagtattctgcaatgacaagtcatatggtc
aaagtaatgaaacggccccaccaggttccgccaatgaaggtcgaccctga
gg
>EF491739
tccttccaactgttgccaactttccaactacaagacacactgaaccagaa
actacgcggagacctctgtcgccttcaaaaatgacaccttctcttccttc
tcctaccaccaccactttgcctgttttctttttgtcacaaatcactgacg
gcgatgaatcagaagatgaa
```

**Outputs sequence name and length:**

```tsv
EF491733    135
EF491734    155
EF491735    140
EF491736    146
EF491737    150
EF491738    152
EF491739    170
``` 

I made this today when I needed a way to generate sequence lengths required for some ChIP-Seq analysis.
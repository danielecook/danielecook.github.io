---
title: Generate fasta sequence lengths
author: Daniel Cook
layout: post
permalink: /generate-fasta-sequence-lengths/
keyword_cache:
  - 'a:1:{s:13:"keywords_time";i:1407984927;}'
dsq_thread_id:
  - 2933039393
rp4wp_cached:
  - 1
rp4wp_auto_linked:
  - 1
categories:
  - Bash
  - Bioinformatics
  - Programming
tags:
  - FASTA
  - gist
  - one-liner
---
**This one liner:**

{% include gist id="394958db37c4d01f0ef3" %}

**Takes a fasta file as input:**

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
    

**Outputs sequence name and length:**

    EF491733    135
    EF491734    155
    EF491735    140
    EF491736    146
    EF491737    150
    EF491738    152
    EF491739    170
    

I made this today when I needed a way to generate sequence lengths required for some ChIP-Seq analysis.
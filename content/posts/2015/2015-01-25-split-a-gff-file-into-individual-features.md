---
title: Split a GFF File into Individual Features
author: Daniel Cook
layout: post
aliases:
  -  /split-a-gff-file-into-individual-features/
date: 2015-01-25
tags:
  - gff
  - gist
---
The [General Feature Format][1] is a widely used format for annotating genome sequences. If indexed with tabix, gff files can be viewed in IGV or elsewhere. While features are organized in a nested manner (e.g. genes > exons > variant), you can pull out the individual types and index them, or combine only a few for viewing in your genome browser.

I was working with [wormbase][2] annotation files, which combine all the different types of features together (genes, ncRNA, mRNA, binding site, operon, G Quartets, piRNAs, etc). This results in a very dense track in IGV which makes it difficult to disentangle what role individual features (or features of interest) might have.

As a result, I wrote this very short script for splitting the individual feature types apart, sorting them, and indexing them with tabix. This way they can be selectively viewed in IGV or elsewhere.

```python
import sys

current_feature = ""

for line in sys.stdin:
    feature = line.split("\t")[2]
    if feature != current_feature:
        f = file(feature + ".gff", "a+")
    f.write(line)
```

```bash
gunzip -kfc <GFF> | grep -v ^"#" | sort -k3,3 | python process_gff.py

for i in `ls *.gff`; do
    (grep ^"#" $i.gff; grep -v ^"#" $i.gff | sort -k1,1 -k4,4n) | bgzip > $i.sorted.gff.gz;
    tabix $i.sorted.gff.gz
    rm $i.gff
done
```

 [1]: http://www.ensembl.org/info/website/upload/gff.html
 [2]: ftp://ftp.wormbase.org/pub/wormbase/releases/WS245/species/c_elegans/PRJNA13758/
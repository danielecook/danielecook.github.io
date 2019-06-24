---
title: Fetch Data from UCSC Genome Browser
author: Daniel Cook
layout: post
aliases:
  - /fetch-data-from-ucsc-genome-browser/
date: 2013-11-03
tags:
  - gist
  - python
---

## Original Post (2013-11-03)

[Previously][1], I&#8217;ve shown that you can use a mysql database browser (e.g. [Sequel Pro][2]) to access and browse the UCSC Genome Browser MySQL database.

If you have a small dataset that you would like to annotate, you can write [SQL][3] statements to fetch data. Below I show how you can use python to fetch genome coordinates by specifying gene and genome build.  

```python
# Note: Requires mysqldb; install using:
# pip install MySQL-python
from MySQLdb.constants import FIELD_TYPE
import _mysql

db = None

def fetch_gene_coordinates(gene_name, build):
    global db # db is global to prevent reconnecting.
    if db is None:
        print 'connect'
        conv= { FIELD_TYPE.LONG: int }
        db = _mysql.connect(host='genome-mysql.cse.ucsc.edu', user='genome', passwd='', db=build,conv=conv)
    db.query("""SELECT * FROM kgXref INNER JOIN knownGene ON kgXref.kgID=knownGene.name WHERE kgXref.geneSymbol = '%s'""" % gene_name)

    r = db.use_result().fetch_row(how=1, maxrows=0)
    print r
    if len(r)>1:
        pass
    else:
        return r[0]['txStart'], r[0]['txEnd'], r[0]['chrom'],r[0]['strand']


print fetch_gene_coordinates('klf1', 'mm9')
```

* * *

__Note:__ The UCSC browser mysql resource will throttle you if you make too many queries. If you need to annotate large datasets, all of the data is freely available for download [here][4].

## Update: cruzdb (2019-06-18)

Since writing this post, [cruzdb](https://github.com/brentp/cruzdb/) has been published. `cruzdb` is a python module by [brentp](https://github.com/brentp) that greatly simplifies and facilitates queries of the UCSC genome browser.

[Bioinformatics publication](https://doi.org/10.1093/bioinformatics/btt534)

### Installation

```bash
pip install cruzdb
```

__Examples__

```python
>>> from cruzdb import Genome

>>> g = Genome(db="hg18")

>>> muc5b = g.refGene.filter_by(name2="MUC5B").first()
>>> muc5b
refGene(chr11:MUC5B:1200870-1239982)

>>> muc5b.strand
'+'

# the first 4 introns
>>> muc5b.introns[:4]
[(1200999L, 1203486L), (1203543L, 1204010L), (1204082L, 1204420L), (1204682L, 1204836L)]

# the first 4 exons.
>>> muc5b.exons[:4]
[(1200870L, 1200999L), (1203486L, 1203543L), (1204010L, 1204082L), (1204420L, 1204682L)]

# note that some of these are not coding because they are < cdsStart
>>> muc5b.cdsStart
1200929L
```


 [1]: /accessing-the-ucsc-genome-browser-mysql-database/
 [2]: http://www.sequelpro.com/
 [3]: http://www8.silversand.net/techdoc/teachsql/ch01.htm
 [4]: http://hgdownload-test.cse.ucsc.edu/goldenPath/


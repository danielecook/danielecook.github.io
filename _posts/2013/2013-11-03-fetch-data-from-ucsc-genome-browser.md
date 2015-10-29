---
title: Fetch Data from UCSC Genome Browser
author: Daniel Cook
layout: post
permalink: /fetch-data-from-ucsc-genome-browser/
dsq_thread_id:
  - 1932950573
keyword_cache:
  - 'a:1:{s:13:"keywords_time";i:1399045013;}'
rp4wp_cached:
  - 1
rp4wp_auto_linked:
  - 1
categories:
  - Bioinformatics
  - Genetics
tags:
  - gist
  - python
---
[Previously][1], I&#8217;ve shown that you can use a mysql database browser (e.g. [Sequel Pro][2]) to access and browse the UCSC Genome Browser MySQL database.

If you have a small<sup><strong><a href='#footnote'>✱</a></strong></sup> dataset that you would like to annotate, you can write [SQL][3] statements to fetch data. Below I show how you can use python to fetch genome coordinates by specifying gene and genome build.  

{% include gist id="7088662" %}

* * *

<sup><a name='footnote'>✱</a></sup>* Note: The UCSC browser mysql resource will throttle you if you make too many queries. If you need to annotate large datasets, all of the data is freely available for download [here][4].*</p>

 [1]: /accessing-the-ucsc-genome-browser-mysql-database/
 [2]: http://www.sequelpro.com/
 [3]: http://www8.silversand.net/techdoc/teachsql/ch01.htm
 [4]: http://hgdownload-test.cse.ucsc.edu/goldenPath/
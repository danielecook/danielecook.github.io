---
title: 'HGNC Search &#8211; Instant search of human genes with Alfred'
author: Daniel Cook
layout: post
permalink: /hgnc-search-instant-search-of-human-genes-with-alfred/
keyword_cache:
  - 'a:1:{s:13:"keywords_time";i:1434160819;}'
rp4wp_cached:
  - 1
rp4wp_auto_linked:
  - 1
dsq_thread_id:
  - 
categories:
  - Alfred
  - Bioinformatics
  - Programming
  - Python
  - Utilities
tags:
  - Alfred
  - Database
---
I have put together an Alfred workflow &#8211; this one searches the HGNC database for genes! I have converted the text database from the [HGNC website][1] and configured it for full text search using sqlite. This allows you to lookup genes by their UCSC, Entrez, Vega, Ensembl, and many other identifiers very quickly.

### [<img src="/media/gene-150x150.png" width="25px" /> Download the latest release][2]

## Usage

**Full text search of the HGNC database**

![][3]

**Information and links are provided for individual genes**

![][4]

## Feedback

Please provide feedback. Specifically:

  * What other gene IDs should be displayed by default? (You can currently search for any)
  * What other sites would you like to be able to navigate to.
  * Is there additional information that should be folded in that would be useful?

 [1]: http://www.genenames.org/
 [2]: https://github.com/danielecook/HGNC-Search/releases/latest
 [3]: /media/d1.png
 [4]: /media/d2.png
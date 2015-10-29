---
title: Visualizing Pairwise Queries in R
author: Daniel Cook
layout: post
permalink: /visualizing-pairwise-queries-r/
keyword_cache:
  - 'a:1:{s:13:"keywords_time";i:1407012041;}'
dsq_thread_id:
  - 2895435382
rp4wp_cached:
  - 1
rp4wp_auto_linked:
  - 1
categories:
  - Bioinformatics
tags:
  - gist
---
<img src="/media/diseasexorg.png" alt="diseasexorg" width="585" height="301" class="thumbnail" />

If you are doing a lot biological research and are interested in identifying whether an association exists between all the pairwise combinations between two sets of terms (e.g. two gene lists), you can use pubmed search results as a proxy for relative association.

In the example below, I show the results from organisms x diseases to give a rough estimate of how much each disease is studied in a given organism. Of course, this should all be taken with a (big) grain of salt because these organisms and diseases have many synonyms or related terms (e.g. *M. Musculus* is often referred to as Mouse in the literature). Additionally, the result count is based off of whether or not the terms were found together within the title and abstract of the literature only &#8211; and not the body of the text in many cases.

<div class="oembed-gist">
  <noscript>
    View the code on <a href="https://gist.github.com/danielecook/5ea8d34679fb197941c0">Gist</a>.
  </noscript>
</div>
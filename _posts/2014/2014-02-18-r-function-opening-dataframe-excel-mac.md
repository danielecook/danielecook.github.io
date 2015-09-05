---
title: An R Function for Opening a dataframe in Excel (Mac Only)
author: Daniel Cook
layout: post
permalink: /r-function-opening-dataframe-excel-mac/
dsq_thread_id:
  - 2281344997
keyword_cache:
  - 'a:1:{s:13:"keywords_time";i:1399045013;}'
rp4wp_cached:
  - 1
rp4wp_auto_linked:
  - 1
categories:
  - Programming
  - R
  - Tips
tags:
  - excel
  - R
---
Coming from Stata, I have found the dataframe viewer to be inadequate in [RStudio][1]. I am just looking for simple sorting, rearranging, and filtering. That is why I wrote this simple function for opening a dataframe in Excel. The file is saved to a temporary data folder with a random set of letters (to avoid annoying dialogues in excel warning you about opening a file again).

This may be worth sticking in your `.RProfile` so it is always available.

It would be great to see a cross-platform solution, possibly browser based that allows simple rearranging, sorting, and filtering of columns on the fly. If anyone is interested in collaborating on such a solution or knows of one please let me know.

<pre class='prettyprint lang-r'>excel &lt;- function(df) {
  f &lt;- paste0(tempdir(),'/', make.names(deparse(substitute(df))),'.',paste0(sample(letters)[1:5],collapse=""), '.csv')
  write.csv(df,f)
  system(sprintf("open -a 'Microsoft Excel' %s",f))
}
</pre>

To use, just type:

<pre class='prettyprint lang-r'>excel(df)
</pre>

...and Microsoft Excel will open with the dataframe (or filtered dataframe).

 [1]: http://www.rstudio.com/
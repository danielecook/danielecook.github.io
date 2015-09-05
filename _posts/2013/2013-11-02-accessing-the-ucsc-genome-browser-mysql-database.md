---
title: Accessing the UCSC Genome Browser MySQL Database
author: Daniel Cook
layout: post
permalink: /accessing-the-ucsc-genome-browser-mysql-database/
dsq_thread_id:
  - 1930001733
keyword_cache:
  - 'a:1:{s:13:"keywords_time";i:1399045013;}'
rp4wp_cached:
  - 1
rp4wp_auto_linked:
  - 1
categories:
  - Bioinformatics
  - Genetics
---
The UCSC Genome browser has a [publicly available MySQL database][1]. There are a lot of different ways you can use it, including:

  * Annotating a small dataset
  * Understanding how data is formatted, and can be used.
  * Browsing Data

If you are on a mac &#8211; [Sequel Pro][2] is a fantastic tool for browsing.

<!--more-->

### Connecting

To browse the UCSC genome browser database, download [Sequal Pro][2] and enter in the following connection information into the login screen:

<img src="http://45.55.80.146/media/Screen-Shot-2013-10-25-at-3.56.23-PM.png" alt="UCSC MySQL" style='width:200px; border: 1px solid black;' class="alignnone size-thumbnail wp-image-355" />

You should be presented with a screen that looks like this:

[<img src="http://45.55.80.146/media/Screen-Shot-2013-10-25-at-4.05.16-PM1.png" alt="Browsing UCSC Genome MySQL database" width="2384" height="1792" class="alignnone size-full wp-image-362" />][3]

Databases are represented as **Connection/Resource > Database > Tables > Rows**. Sequal pro lets you connect to the UCSC Browser MySQL server. Each **database** represents a different genome. Remember that genomes change and improve over time &#8211; so there are multiple **builds** of each genome (e.g. hg18 and hg19) represented by separate databases.

Within each database are tables. These are the same tables referred to on the UCSC website &#8211; and you can find out more about what the data represents on the browser website by clicking &#8216;describe table schema&#8217; for the table of interest as shown below.

[<img src="http://45.55.80.146/media/Screen-Shot-2013-10-25-at-3.51.29-PM-1024x232.png" alt="Screen Shot 2013-10-25 at 3.51.29 PM" width="940" height="212" class="alignnone size-large wp-image-367" />][4]

 [1]: http://genome.ucsc.edu/goldenPath/help/mysql.html
 [2]: http://www.sequelpro.com/
 [3]: http://45.55.80.146/media/Screen-Shot-2013-10-25-at-4.05.16-PM1.png
 [4]: http://45.55.80.146/media/Screen-Shot-2013-10-25-at-3.51.29-PM.png
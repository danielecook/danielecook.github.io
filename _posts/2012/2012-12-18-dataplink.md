---
title: dataplink
author: Daniel Cook
excerpt: |
  <strong>dataplink</strong> is a simple program for importing recoded data from <a href="http://pngu.mgh.harvard.edu/~purcell/plink/">plink</a>. Dataplink imports genotypic data from .ped files and also imports variable names (snp names) from .map files.
  
  <h4>Installation</h4>
  <pre class='prettyprint lang-bsh'>
  ssc install dataplink
  </pre>
layout: post
permalink: /dataplink/
dsq_thread_id:
  - 1650146932
keyword_cache:
  - 'a:1:{s:13:"keywords_time";i:1399072869;}'
rp4wp_cached:
  - 1
rp4wp_auto_linked:
  - 1
categories:
  - Program
  - STATA Programs
tags:
  - plink
  - STATA
---
#### Description



**dataplink** is a simple program for importing recoded data from [plink][1]. Dataplink imports genotypic data from .ped files and also imports variable names (snp names) from .map files.

#### Installation

<pre class='prettyprint lang-bsh'>ssc install dataplink
</pre>

<!--more-->

#### Usage

##### Export from plink

Data from plink must be exported using the following commands:

  * &#8211;recode OR &#8211;recode12
  * &#8211;tab

#### Syntax

<pre class='prettyprint lang-bsh'>dataplink using "/path/to/file/without/extension"</pre>

<div class="alert alert-warning">
  <h4>
    Important!
  </h4>
  
  <p>
    When you specify the <em>filename</em> do not use extensions (i.e. do not add <strong>.ped</strong> or <strong>.map</strong>). Dataplink looks for a .map and .ped file of the same name. </div> 
    
    <h4>
      Limits
    </h4>
    
    <p>
      STATA SE and MP flavors support a maximum of 32,767 variables while IC supports 2,047. This means you can only import ~32,000 SNPs with SE/MP or ~2,000 with IC.
    </p>

 [1]: http://pngu.mgh.harvard.edu/~purcell/plink/
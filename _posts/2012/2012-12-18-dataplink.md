---
title: dataplink
author: Daniel Cook
layout: post
permalink: /dataplink/
categories:
  - STATA Programs
---


**dataplink** is a simple program for importing recoded data from [plink][1]. Dataplink imports genotypic data from .ped files and also imports variable names (snp names) from .map files.

#### Installation

```bash
ssc install dataplink
```

#### Usage

##### Export from plink

Data from plink must be exported using the following commands:

  * &#8211;recode OR &#8211;recode12
  * &#8211;tab

#### Syntax

```bash 
dataplink using "/path/to/file/without/extension"
```

<div class="alert alert-warning">
  <h4>Important!</h4>
  
  <p>
    When you specify the _filename_ do not use extensions (i.e. do not add __.ped__ or __.map__). Dataplink looks for a .map and .ped file of the same name. </div> 
    
#### Limits

STATA SE and MP flavors support a maximum of 32,767 variables while IC supports 2,047. This means you can only import ~32,000 SNPs with SE/MP or ~2,000 with IC.

 [1]: http://pngu.mgh.harvard.edu/~purcell/plink/
---
title: Fetch Citations in Google Sheets using pubmed() function
author: Daniel Cook
layout: post
permalink: /fetch-citations-google-sheets/
categories:
  - Alfred
  - Utilities
tags:
  - Alfred
  - Wormbase
---

If you need to fetch pubmed citations in aggregate it can be convenient to do so using pubmed identifiers. I've created a `pubmed()` function that can be added to a google sheet and used to fetch formatted html citations from pubmed. For example, entering the following into a cell:

```
=pubmed(23149456)
```

Will return an html-formatted citation:

```
<p><strong>The heritability of metabolic profiles in newborn twins.</strong><br />Alul FY, Cook DE, Shchelochkov OA, Fleener LG, Berberich SL, Murray JC, Ryckman KK, <br />(2013 Mar) <em>Heredity</em> 110 (3) 253-8</p>
```

This citations formats nicely as:

<div class="panel panel-default">
  <div class="panel-body">
<p><strong>The heritability of metabolic profiles in newborn twins.</strong><br />Alul FY, Cook DE, Shchelochkov OA, Fleener LG, Berberich SL, Murray JC, Ryckman KK, <br />(2013 Mar) <em>Heredity</em> 110 (3) 253-8</p>
</div>
</div>

### Setup

To implement the function, you'll need to copy and paste the function below into the script editor and save it as a new project. Then it will become available within your google sheet. The script editor is available through the `Tools > Script Editor`

```javascript

/**
 * Returns formatted pubmed citation.
 *
 * @param {id} Pubmed identifier.
 * @return Formatted pubmed citation.
 * @customfunction
 */
function pubmed(id) {
  // Special thanks to http://www.alexhadik.com/blog/2014/6/12/create-pubmed-citations-automatically-using-pubmed-api
  var content =  UrlFetchApp.fetch("http://eutils.ncbi.nlm.nih.gov/entrez/eutils/esummary.fcgi?db=pubmed&id=" + id + "&retmode=json")
  summary = JSON.parse(content)
  
  var title = summary.result[id].title;
  var journal = summary.result[id].fulljournalname;
  var volume = summary.result[id].volume;
  var issue = summary.result[id].issue;
  var citation = "";
  var pub_date = summary.result[id].pubdate;
  var pages = summary.result[id].pages;
 
  var authors = "";
  for(author in summary.result[id].authors){
    authors+=summary.result[id].authors[author].name+', ';
  }
  
  var citation = "<p><strong>" + title + "</strong><br />" +
                 authors + "<br />" +
                 "(" + pub_date + ") <em>" + journal + "</em> " + 
                 volume + " (" + issue + ") " + pages + "</p>";
                 
  
  return citation
}

```

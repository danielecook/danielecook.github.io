---
title: Fetch Citations in Google Sheets using pubmed() function
author: Daniel Cook
layout: post
permalink: /fetch-citations-google-sheets/
categories:
  - Programming
tags:
  - Google Sheets
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
	<p style="margin-bottom: 0px;">
		<strong>The heritability of metabolic profiles in newborn twins.</strong>
		<br />Alul FY, Cook DE, Shchelochkov OA, Fleener LG, Berberich SL, Murray JC, Ryckman KK, 
		<br />(2013 Mar) <em>Heredity</em> 110 (3) 253-8
	</p>
	</div>
</div>

### Setup

To implement the function, you'll need to copy and paste the function below into the script editor and save it as a new project. Then it will become available within your google sheet. The script editor is available through the `Tools > Script Editor`

{% gist 13a27f57ab5f1ff38dcd %}

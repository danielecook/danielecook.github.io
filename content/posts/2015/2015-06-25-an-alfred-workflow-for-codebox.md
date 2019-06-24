---
title: An Alfred Workflow for Codebox
author: Daniel Cook
layout: post
aliases:
  -  /an-alfred-workflow-for-codebox/
date: 2015-06-25
tags:
  - Alfred
---
[Codebox]() is a great program for storing and accessing snippets. It offers a quickbar menu item, but I thought Alfred might offer more functionality. So I wrote a workflow for it.

### [<img src="https://raw.githubusercontent.com/danielecook/codebox-alfred/master/5EA0CB7E-736D-475C-974F-A761791C582A.png" style="height:27px;margin-right:10px" />Download Codebox-Alfred workflow][1]

## Important!

The workflow works fairly well, but there are a few caveats. You should not do the following with your codebox libraries:

  * Don&#8217;t put spaces into tag, list, or folder names. Use an underscore instead.
  * Don&#8217;t nest folders/lists with the same name. 

## Usage

**Set the codebox source using `cb_src`**

![set source][2]

**Invoke the workflow by typing `ff`**

![search directory][3]

**Browse tags with `ff #<search>`**  
![search tags][4]

**Search all Snippets: `ff <search>`**

![search all][5]

 [1]: https://github.com/danielecook/codebox-alfred/releases/latest
 [2]: http://github.com/danielecook/codebox-alfred/raw/master/img/set_src.png
 [3]: http://github.com/danielecook/codebox-alfred/raw/master/img/browse_directory.png
 [4]: http://github.com/danielecook/codebox-alfred/raw/master/img/search_tags.png
 [5]: http://github.com/danielecook/codebox-alfred/raw/master/img/search_snippets.png
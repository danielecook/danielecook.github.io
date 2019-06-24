---
title: Alfred Workflow for Creating a Data Analysis Project
author: Daniel Cook
layout: post
date: 2014-01-25
aliases:
  - /alfred-workflow-creating-new-project/
tags:
  - Alfred
---

This idea I got from my brother. The idea is to keep any data analysis/bioinformatic projects I work on organized by sticking to a standard template. I wrote an Alfred Workflow for generating the template. There are a couple key features:

![Directory Structure](/Screen-Shot-2014-01-20-at-12.33.18-AM.png)

<small>Directory Structure</small>

  * __Markdown (md) extension__ &#8211; is used for the readme because its simple and so that the directory is ready for github if desired.
  * **Data Folder** &#8211; This directory is used for storing raw data and scripts that are used to clean and prepare data for analysis.
  * **analysis** &#8211; This directory contains the scripts for producing statistics and visualizing data. 
      * __report__ &#8211; any publications or presentations that come of the project can be stored in the report folder. 
          * **run.sh** is a two line script that will run prepare_data.sh and analysis.sh. This allows you to [reproduce][1] the entirety of your work all at once and verify your results. </ul> 
        What are your thoughts? How could this be improved?
        
## Usage

Navigate to the directory where you would like to create the project template; open alfred and type

```bash
project [a name for your project]
```

<br />

#### [Download](/createproject.alfredworkflow)

 [1]: http://phys.org/news/2013-09-science-crisis.html
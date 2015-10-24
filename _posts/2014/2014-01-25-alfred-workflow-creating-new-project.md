---
title: Alfred Workflow for Creating a Data Analysis Project
author: Daniel Cook
layout: post
permalink: /alfred-workflow-creating-new-project/
dsq_thread_id:
  - 2147417973
keyword_cache:
  - 'a:1:{s:13:"keywords_time";i:1399045013;}'
rp4wp_cached:
  - 1
rp4wp_auto_linked:
  - 1
categories:
  - Alfred
  - Bioinformatics
  - Misc
  - Tips
  - Utilities
tags:
  - Alfred
---
This idea I got from my brother &#8211; the idea is to keep any data analysis/bioinformatic projects I work on organized by sticking to a standard template. I wrote an Alfred Workflow for generating the template. There are a couple key features:

<div class='thumbnail pull-right'>
  <img src="/media/Screen-Shot-2014-01-20-at-12.33.18-AM.png" class='pull-right' alt="Directory Structure" width="205" height="149" class="size-full wp-image-439" /> 
  
  <div class="caption">
    Directory Structure
  </div>
</div>

  * **Markdown (md) extension** &#8211; is used for the readme because its simple and so that the directory is ready for github if desired.
  * **Data Folder** &#8211; This directory is used for storing raw data and scripts that are used to clean and prepare data for analysis.
  * **analysis** &#8211; This directory contains the scripts for producing statistics and visualizing data. 
      * **report** &#8211; any publications or presentations that come of the project can be stored in the report folder. 
          * **run.sh** is a two line script that will run prepare_data.sh and analysis.sh. This allows you to [reproduce][1] the entirety of your work all at once and verify your results. </ul> 
        What are your thoughts? How could this be improved?
        
        #### Usage
        
        Navigate to the directory where you would like to create the project template; open alfred and type  
        `project [a name for your project]`
        
        #### Download
        
        <div class='well download' style="clear:both;">
          <a class='download_link' href="/downloads/createproject.alfredworkflow"><img class='download_img' src='/media/createproject.png' style='float:left;width:50px;' /><br /> <strong>Create_Project.alfredworkflow</strong></a></p>
        </div>

 [1]: http://phys.org/news/2013-09-science-crisis.html
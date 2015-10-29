---
title: How to plot all of your Runkeeper Data
author: Daniel Cook
layout: post
permalink: /how-to-plot-all-of-your-runkeeper-data/
keyword_cache:
  - 'a:1:{s:13:"keywords_time";i:1401128615;}'
dsq_thread_id:
  - 
rp4wp_cached:
  - 1
rp4wp_auto_linked:
  - 1
categories:
  - Programming
  - R
tags:
  - biking
  - gist
  - running
---
<div class='row' style="padding:20px;">
  <div class="col-md-6">
    <div class='thumbnail'>
      <img src="/media/Screen-Shot-2014-05-27-at-10.50.04-PM.png" alt="Screen Shot 2014-05-27 at 10.50.04 PM" width="232" height="300" class="alignnone wp-image-534" /></p> 
      
      <div class="caption">
        <small>Runs in Iowa City</small>
      </div>
    </div>
  </div>
  
  <div class="col-md-6" >
    <div class='thumbnail'>
      <img src="/media/2-all-107x300.png" alt="2-all" width="107" height="300" class="alignnone wp-image-502" /></p> 
      
      <div class="caption">
        <small>Running and Biking in Chicago</small>
      </div>
    </div>
  </div>
</div>

* * *

If you use [runkeeper][1] and pay for a yearly subscription (runkeeper elite), you can export your data and plot all of your activities simultaneously using [**R**][2]. I&#8217;ve written a script for doing so (Special thanks to [flowing data][3] which has a tutorial that helped with a few key parts of this).

The script does a few unique things.

  * Runkeeper exports data in [gpx format][4]. If you ever pause an activity within runkeeper or you lose GPS reception briefly, the GPS path will get split into multiple paths within the same file. The script will retain all paths and plot them separately.
  * This script will merge in the type of activities so you can plot different types of activities by color.
  * Finally, cluster analysis is used to segregate different locations when plotting. If you are like me and have moved around a bit &#8211; this is necessary as plotting distant locations on the same map (e.g. Chicago and Boston) is not feasible and results in distant locations being plotted as single points.  
    <!--more-->

#### Directions

  1. Export your runkeeper data. The option is available for subscribers only under the settings menu.

[<img src="/media/Screen-Shot-2014-05-27-at-8.09.00-PM-300x198.png" alt="Exporting Runkeeper Data" width="300" height="198" class="img-thumbnail size-medium wp-image-520" />][5]

<p class='caption'>
  <small>Exporting can be done from within the settings menu</small>
</p>

  1. Place the script below within a folder containing your runkeeper data. Set the `num_locations` variable to the number of places you have lived/run. This will be used to pull out the number of distinct running locations automatically.</p> 
  2. Install the necessary R packages. You can run the following code within R to do so.
    
    <pre>install.packages("fpc")
install.packages("plyr")
install.packages("dplyr")
install.packages("mapproj")</pre>

  3. Run the script from within R Studio or on unix based machines using `RScript plot_runkeeper.R`. If you are using Rstudio, be sure to set the working directory using `setwd()`

 [1]: http://www.runkeeper.com
 [2]: http://www.r-project.org/
 [3]: http://www.flowingdata.com.com
 [4]: http://www.topografix.com/gpx.asp
 [5]: /media/Screen-Shot-2014-05-27-at-8.09.00-PM.png
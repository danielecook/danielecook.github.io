---
title: Get rid of the Microsoft User Data folder
author: Daniel Cook
excerpt: Put the Microsoft User Data Folder in a better location
layout: post
permalink: /get-rid-microsoft-user-data-folder/
dsq_thread_id:
  - 1665938298
keyword_cache:
  - 'a:1:{s:13:"keywords_time";i:1399045013;}'
rp4wp_cached:
  - 1
rp4wp_auto_linked:
  - 1
categories:
  - Tips
---
Who thought it would be a good idea to put this crap in the documents folder? Here is a quick one liner solution &#8211; open a terminal window and paste this in:

<pre class='prettyprint'>mv /Users/$USER/Documents/Microsoft\ User\ Data/ /Users/$USER/Library/Preferences/
</pre>

Thanks to [Danny Chang][1] for the tip.

 [1]: http://imdanny.com/blog/technology/go-away-microsoft-remove-annoying-microsoft-user-data-folder/
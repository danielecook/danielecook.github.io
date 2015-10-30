---
title: Install Tabix and Samtools on Mac
author: Daniel Cook
layout: post
permalink: /installing-tabix-and-samtools-on-mac/
dsq_thread_id:
  - 1951413943
rp4wp_cached:
  - 1
rp4wp_auto_linked:
  - 1
categories:
  - Bioinformatics
tags:
  - homebrew
  - sequencing
  - vcf
---
I was having a tough time getting Tabix and Samtools installed on my mac &#8211; but found a very easy way to do it. You&#8217;ll have to install [Homebrew][1] and [xcode][2].

**[xcode][2]** can be installed using the appstore.

Homebrew can be installed by copying and pasting the following into the terminal:

<pre class='prettyprint lang-bsh'>ruby -e "$(curl -fsSkL raw.github.com/mxcl/homebrew/go)"</pre>

Next you type this:

<pre class='prettyprint lang-bsh'>brew tap homebrew/science
brew install tabix
brew install samtools
</pre>

And you are done. Homebrew has easy commands for symlinking these too. These details are mentioned when you install items.

 [1]: http://mxcl.github.com/homebrew/
 [2]: https://itunes.apple.com/us/app/xcode/id497799835?mt=12
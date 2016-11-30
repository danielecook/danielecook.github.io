---
title: Sync STATA programs and settings with Dropbox
author: Daniel Cook
layout: post
permalink: /sync-your-ado-directory-in-stata-across-computers/
categories:
  - Programming
---
With the release of STATA 12, users are allowed to install STATA across platform (linux, mac, windows) on up to three computers/user. If you frequently install/edit programs you can sync files from the ado directory, where programs are stored, across your computers using [Dropbox][1].  
<!--more-->

#### Step 1: Install Dropbox

Go to [Dropbox][1], signup for an account and install.

#### Step 2: Create an ado directory

Create the following directories within your dropbox directory:

  1. dropbox/ado
  2. dropbox/ado/plus &#8211; For installed ado files.
  3. dropbox/ado/personal &#8211; For personal ado files

#### Step 3: Edit profile.do

**profile.do** is a file that runs every time you startup STATA. STATA will look in a variety of places for the file depending on your operating system. Type **help profile** for more information on where it is stored on your operating system.

This file needs to be created and edited on each system you want to sync. Here&#8217;s where you might store it on Mac and linux:

  * **Mac **/Users/[your username]/Library/Application Support/Stata/ado/personal/profile.do 
  * **Linux** /bin/profile.do

Next you need to edit this file on each system to point at the appropriate dropbox directory. On Mac this might look like this:

<pre>*! profile.do
sysdir set PERSONAL "~/Dropbox/ado/personal/"
sysdir set PLUS "~/Dropbox/ado/plus/"
</pre>

Restart STATA and you should see something like this:

<pre>running /Users/Dan/Library/Application Support/Stata/ado/personal/profile.do 
</pre>

Dropbox does the rest &#8211; syncing across your systems. You can run an additional do file located in your dropbox folder if you want to centrally edit startup settings like setting memory or turning the &#8216;more&#8217; option off.

 [1]: http://www.dropbox.com
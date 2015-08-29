---
layout: post
category : lessons
tagline: "Cool"
tags : [intro, beginner, jekyll, tutorial]
---

I was having a tough time getting Tabix and Samtools installed on my mac – but found a very easy way to do it. You’ll have to install Homebrew and xcode.

xcode can be installed using the appstore.

Homebrew can be installed by copying and pasting the following into the terminal:

``` python
ruby -e "$(curl -fsSkL raw.github.com/mxcl/homebrew/go)"
```

Next you type this:

``` bash
brew tap homebrew/science
brew install tabix
brew install samtools
```

And you are done. Homebrew has easy commands for symlinking these too. These details are mentioned when you install items.
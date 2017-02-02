---
title: Python Command-line skeleton
author: Daniel Cook
layout: post
permalink: /python-cli-skeleton/
published: true
categories: 
    - Python
---

Writing a command-line interface (CLI) is an easy way to extend the functionality and ease of use of any code you write. 

Python comes with the built-in module, [argparse](https://docs.python.org/3/library/argparse.html), that can be used to easily develop command-line interfaces. To speed up the process, I have developed a 'skeleton' application that can be forked on github and used to quickly develop CLI programs in python. 

The repo has the following features added:

* Testing with travis-ci and py.test
* Coverage analysis using coveralls
* A setup file that will install the command
* a simple argparse interface

To get started, you should signup for an account on [travis-ci](http://www.travis-ci.org) and [coveralls](http://www.coveralls.io).

<a href='https://github.com/danielecook/python-cli-skeleton' class="btn btn-large" type="submit"><img src='/assets/img/repo.svg' style='width: 16px; margin-right: 5px;' alt='repo' /> python-cli-skeleton on Github</a>
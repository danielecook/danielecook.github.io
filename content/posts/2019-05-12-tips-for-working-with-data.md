---
title: Structuring scientific projects
author: Daniel Cook
layout: post
aliases:
  - /tips-for-working-with-data/
published: true
date: 2019-05-12
comments: true
tags:
  - Data
draft: true
---

How to organize and work with data is an essential, often lacking skill in academia. Many graduate students will start a new project or pick up an existing project for a few years before handing it off to another student. Projects often suffer from one of the following:

* Little to no written documentation
* Failure to anticipate how a project will evolve over time
* Poor organization of files
* 

Often, students are unable to anticipate how projects will evolve over time and appropriately account for how these changes will affect data management.

Below I lay out some ideas regarding how to develop projects in a way such that they will be flexible to future changes, 

# Technical debt

From [Wikipedia](https://en.wikipedia.org/wiki/Technical_debt)

> Technical debt (also known as design debt[1] or code debt) is a concept in software development that reflects the implied cost of additional rework caused by choosing an easy (limited) solution now instead of using a better approach that would take longer.

# Follow Karl Broman's guidelines

Karl Broman is a statistician at the University of Wisconsin Madison. He has written an excellent guide on working with datasets - specifically geared toward organization of data in spreadsheets.

[data organization - broman](https://kbroman.org/dataorg/)

Highlights:

# Documentation

Documentation takes a lot of time to write which is probobly one reason you see it so infrequently. However, it is worth noting that 


# Do not rename raw data files

It can be tempting to rename a file named `e8319954-9199-11e9-987b-a45e60e49769` as its associated sample name (e.g. `TCGA-001`), especially when you have obtained the data from a remote resource. <strong>Don't do this</strong>. Why? You are throwing away important - essential - informtion about the file. That name is unique, telling us potentially exactly where it was obtained remotely.

# Create a sample sheet



# The `README.md`

The `README` is the entrypoint for your project. It is generally a plaintext file written in [markdown](https://daringfireball.net/projects/markdown/).  This is where you describe who was involved, and what the project is for. You can also use the README.md, and provide either all the documentation or point users towards more of it.

Other important details to include are:

* When data associated with the project can be deleted, or who to contact to ask.

# Comments

* Who is involved, and their emails
* 


# Do not rename raw data files

It can be tempting to rename a file named `e8319954-9199-11e9-987b-a45e60e49769`


# Keep identifiers simple 

Identifiers should only really do two things:

1. Indicate the type of entity they are referencing
2. Reference an entity

Identifiers are essential for referring to entities such as samples, patients, records, etc. Keep identifiers simple - their primary goal is to identify an entity, not specify information about that entity. For example, suppose you run an ice cream shop and wanted to develop identifiers for different types of ice cream. You may decide to incorporate information about those entities into the identifiers themselves. For example:

```
IC_CHOCOLATE
IC_VANILLA
IC_STRAWBERRY
```

__Do not do this__. Things can get complicated over time. Your business grows, and you start to carry a dark chocolate ice cream, and you also have new variants that are low in sugar. So now you think you have to rethink your identifiers: 

```
IC_CHOCOLATE_NORMAL
IC_CHOCOLATE_LOW
IC_DARK_CHOCOLATE_NORMAL
IC_VANILLA_NORMAL
IC_VANILLA_LOW_NORMAL
```

Now you have several problems. You can no longer match old sales records because you have changed the identifiers. Worse - the data is difficult to parse. `DARK_CHOCOLATE` is two words, which means you can't simply split the identifier records by underscores (`_`) to parse out what they refer to.

So how do you avoid these issues in the first place?

Use a prefix and numbers for identifiers, and store the information regarding what they are elsewhere. It's trivial to combine existing datasets with this information using a left-join if need be.

```
IC_1
IC_2
IC_3
IC_4
IC_5
```

Note the use of a prefix here - which is the only 'extra' thing that you should consider using when developing an identifier. It's useful for knowing the type of entity that is being referenced.


Another advantage of a prefix on identifiers is that it prevents Microsoft Excel (an unavoidable software in most fields) from parsing it as an integer.

## The naming of files
Be deliberate in naming files. The delimiters should make sense, and be a fixed number of digits.

Use a prefix
_ joins IDs
-, . separate pieces of information.
<run>-<asdf>, etc.
Use identical formats with no exceptions
Make your IDS the same width - always; Why? Because X1 and X10 will both be matched by ‘X1’ when trying to search.
Dates
Use a fixed width identifier
No spaces

If you use filenames to keep track of things, do not use variable numbers

## Pad identifiers with extra zeros

You should pad identifiers to make them an even width. This makes them easier to read and work with. Use at least 3 orders of magnitude beyond what you would expect to collect at the beginning of your project. If you expect to collect 300 samples, pad sample numbers as 00001, 00002, etc. You may go beyond 1000. 

## URLs and file paths leave off trailing slash by convention

### Use original file names; Create a file that links to new file names

### IDs do not store data. They should only be used to link records

### Do not hard code changes in

### Assemble once and filter; Do

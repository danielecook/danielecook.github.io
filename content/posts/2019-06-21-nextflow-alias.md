---
title: Useful Nextflow bash functions for SLURM
author: Daniel Cook
layout: post
aliases:
  -  /nextflow-bash-aliases-for-slurm/
date: 2019-06-21
tags:
  - nextflow
  - gist
draft: true
---

If you use [Nextflow](http://www.nextflow.io) on a cluster with the SLURM scheduler, than these bash functions may be useful to you and worth sticking in your `.bashrc`.

```bash
# Shortcut for going to work directories
# Usage: gw <workdir pattern>
# Replace the work directory below as needed
# Where workdir pattern is something like "ab/afedeu"
function gw {
        path=`ls --color=none -d /path/to/work/directory/$1*`
        cd $path
}

# sq squeue alternative
# Outputs more complete information about jobs including the work directory
function sq() {
    squeue --user `whoami` --format='%.18i %50j %10u %.10C %m %20J %M %.2t %n %R %Z' | awk -v OFS='\t' '{ match($10, /([a-f0-9]{2}\/[a-f0-9]{6})/, arr); print $1, $2, $3, $4, $5, $6, $7, $8, $9, arr[1] }' 
}
```

[gist](https://gist.github.com/danielecook/bae19b7b9191b76fb6972bd7ef16718d)
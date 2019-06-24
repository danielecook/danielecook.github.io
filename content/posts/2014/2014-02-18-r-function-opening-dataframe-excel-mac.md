---
title: An R Function for Opening a dataframe in Excel (Mac Only)
author: Daniel Cook
layout: post
date: 2014-02-18
aliases:
  - /r-function-opening-dataframe-excel-mac
tags:
  - excel
  - R
---

The dataframe viewer in [Rstudio][1] can be slow or unresponsive, and at times truncates the content within or the number of columns on large datasets. I want to be able to see the full columns and to be able to arrange and filter simultaneously. Although you can do this in R programmatically sometimes its easier and quicker to use Excel. The function below can be used to open a dataframe in Microsoft Excel.

This may be worth sticking in your `.RProfile` so it is always available.

```R
excel <- function(df) {
  f <- paste0(tempdir(),
              '/',
              make.names(deparse(substitute(df))),
              '.',
              paste0(sample(letters)[1:5],collapse=""),
              '.csv')
  write.csv(df,f)
  system(sprintf("open -a 'Microsoft Excel' %s",f))
}
```

To use, just type:

```R
excel(dataframe)

# Or pipe in using dplyr

df %>% excel()
```

Microsoft Excel will open with the dataframe that has been passed.

 [1]: http://www.rstudio.com/
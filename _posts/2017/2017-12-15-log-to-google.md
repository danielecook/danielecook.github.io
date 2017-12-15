---
title: Alfred Image Utilities
author: Daniel Cook
layout: post
permalink: /log-back-to-google-cloud-logging/
published: true
categories:
    - Bash
---

Google Cloud Platform (GCP) has a service called Stackdriver logging which provides a nice interface for accessing logs.

![](media/gcp-logs.png)

Stackdriver logging is integrated with all GCP services but it can also be extended. Users can create custom logs and access them centrally using the web-based interface or the [Google Cloud SDK](https://cloud.google.com/sdk/).

This got me wondering whether there was a way to log terminal commands locally or on a server. It is possible by setting the `PROMPT_COMMAND` variable in BASH. After a command is submitted the value of `PROMPT_COMMAND` is interpretted (technically it is interpretted before the next prompt is printed to the screen).

I wrote up a quick function that looks to see whether the last command exited successfully (0) or resulted in an error (>0), and log using INFO or ERROR respectively. Then I set the function to the `PROMPT_COMMAND` variable. Note that you may need to activate the gcloud beta logging for this to work.

```bash
function prompt {
if [[ $? -eq 0 ]];then
    (gcloud beta logging write bash_log "`fc -nl -1`" --severity=INFO > /dev/null 2>&1 &)
else
    (gcloud beta logging write bash_log "`fc -nl -1`" --severity=ERROR > /dev/null 2>&1 &)
fi
}

PROMPT_COMMAND=prompt
```

Now check the logging interface and you will see your commands are logged!
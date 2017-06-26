# dockermor
# A tool to remove old docker images and and volumes. 


This tool is projected to be used as a "Sunday" cronjob for registries, gitlab runners and so on. 

Setup dockermor_images.pl as one cron job. 

```
dockermor.pl:
    --all                     -- operate on all found resources. If this is
                                 specified alongside individual resources, this
                                 option takes precedence
    --resource-type=image     -- required
    --older-than-days=<DAYS>  -- time in days that the resource needs to be older than
    --dry-run                 -- perform dry run
    --dry-run-prefix=<STRING> -- prefix of dry run output
    [resource1 resource2 ...] -- names of the resources to operate on
```

#!/bin/bash
#Bash script to output statistics from Storj logs.
#Commands from https://support.storj.io/hc/en-us/articles/360029233952-Some-statistics-from-logs

#Read container name or set default to storagenode
read -p "Enter your Storj Docker Container name[storagenode]: " container
container=${container:-storagenode}

#Commands set to variables
uac=$(docker logs $container 2>&1 | grep GET_AUDIT | grep failed | grep open -c)
rfa=$(docker logs $container 2>&1 | grep GET_AUDIT | grep failed | grep -v open -c)
sa=$( docker logs $container 2>&1 | grep GET_AUDIT | grep downloaded -c)
fd=$(docker logs $container 2>&1 | grep '"GET"' | grep failed -c)
sd=$(docker logs $container 2>&1 | grep '"GET"' | grep downloaded -c)
fu=$(docker logs $container 2>&1 | grep '"PUT"' | grep failed -c)
su=$(docker logs $container 2>&1 | grep '"PUT"' | grep uploaded -c)
fdr=$(docker logs $container 2>&1 | grep GET_REPAIR | grep failed -c)
sdr=$(docker logs $container 2>&1 | grep GET_REPAIR | grep downloaded -c)
fur=$(docker logs $container 2>&1 | grep PUT_REPAIR | grep failed -c)
sur=$(docker logs $container 2>&1 | grep PUT_REPAIR | grep uploaded -c)

#Output results
echo "Count of unrecoverable failed audits: $uac"
echo "Count of recoverable failed audits: $rfa"
echo "Count of successful audits: $sa"
echo "Count of failed downloads from your node: $fd"
echo "Count of successful downloads: $sd"
echo "Count of failed uploads to your node: $fu"
echo "Count of successful uploads to your node: $su"
echo "Count of failed downloads of pieces for repair process: $fdr"
echo "Count of successful downloads of pieces for repair process: $sdr"
echo "Count of failed uploads repaired pieces: $fur"
echo "Count of successful uploads of repaired pieces: $sur"
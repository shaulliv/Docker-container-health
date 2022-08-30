#!/bin/bash
####################################################
# Monitor and restart unhealthy docker containers
# By shaulliv
# shaul@shaulliv.com
# NOTE: if the containers fall repetedly into unhealthy state the script will restart them withoutn notification or resolving the core issue
####################################################

# map into array health1 all containers that are in status unhealthy
mapfile -t health1 < <( docker ps --filter="health=unhealthy" --format '{{.ID}}' )

# for every unhealthy container write status to log file and restart container
for i in "${health1[@]}"
do
        echo `date` "$i" >> /var/log/docker_health.log
        echo `date` restart container "$i" >> /var/log/docker_health.log
        docker container restart "$i" >> /var/log/docker_health.log
done
unset health1

# write to log weather the script worked.
# this is here to monitor weather the script worked even if no containers are unhealthy
echo `date` script worked >> /var/log/docker_health.log

# calculates the length of the log in lines
loglen=$(wc -l /var/log/docker_health.log | awk '{print $1}')

# deletes the oldest 500 lines in the log
# keeps the log from continually growing
if [[ $loglen -gt 500 ]]; then
        sed -i -e :a -e '$q;N;500,$D;ba' /var/log/docker_health.log
fi
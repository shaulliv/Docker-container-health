# Docker-container-health
A simple script to monitor and restart unhealthy containers

## Description
The script checkes weather any containers are in status unhealthy and then restarts them.
It also writes the results to a log file and trims the log file.

### NOTE
If the containers fall repetedly into unhealthy state the script will restart them without notification or resolving the core issue.

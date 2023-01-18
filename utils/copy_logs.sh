#!/bin/bash
# Since SSH is not enabled in a container environment this script can be used 
# when p4 is running in a Kuberneetes cluster to copy the log files from the p4 pod
# and then delete it as well.
# It should be executed after the run_bench.sh script and before the analyse.sh script
# 
# Default usage:
#   ./copy_logs.sh

function bail () { echo "Error: ${1:-Unknown Error}\n"; exit ${2:-1}; }

[[ -z $ANSIBLE_HOSTS ]] && bail "Environment variable ANSIBLE_HOSTS not set"
[[ -e $ANSIBLE_HOSTS ]] || bail "ANSIBLE_HOSTS file not found: $ANSIBLE_HOSTS"

#Obtain number of namespaces configured
container_num_namespace=$(cat $ANSIBLE_HOSTS | yq '.all.container.namespaces | length')
container_pods_name=$(cat $ANSIBLE_HOSTS | yq '.all.container.pod_name')

# Iterate for the number of namespaces configured
for (( c=0; c<container_num_namespace; c++ ))
do
    # Obtain the namespace from the yaml file
    namespace=$(cat $ANSIBLE_HOSTS | yq -r '.all.container.namespaces['$c']')
    echo "Copying log file from pod: $container_pods_name in namespace: $namespace"
    kubectl cp $container_pods_name:/p4/logs/log ./logs/$namespace-log -n $namespace
    echo "File copied"

    echo "Removing log file from pod: $container_pods_name in namespace: $namespace"
    kubectl exec $container_pods_name -n $namespace -it -- rm p4/logs/log
    echo "File removed"
done

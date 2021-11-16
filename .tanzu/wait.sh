#!/bin/bash -e

workloadName=$1
jsonpath='{.items[0].metadata.name}'
while [[ -z $(kubectl get pod --selector carto.run/workload-name=${workloadName},app.kubernetes.io/component=run 2>/dev/null) ]]; do echo "Waiting for new workload \"${workloadName}\"" && sleep 10; done
podName=$(kubectl get pod --selector carto.run/workload-name=${workloadName},app.kubernetes.io/component=run -o jsonpath=$jsonpath)
kubectl wait pod --for=condition=ready $podName

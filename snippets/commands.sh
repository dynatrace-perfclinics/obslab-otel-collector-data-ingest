#!/bin/bash

# Create Cluster
kind create cluster --config .devcontainer/kind-cluster.yml --wait 300s

# Create secret
# --8<-- [start:createSecret]
kubectl create secret generic dynatrace-otelcol-dt-api-credentials \
  --from-literal=DT_ENDPOINT=https://abc12345.live.dynatrace.com/api/v2/otlp \
  --from-literal=DT_API_TOKEN=dt0c01.sample.secret
# --8<-- [end:createSecret]

# Add OTEL Helm Charts and Update
# --8<-- [start:addOTELHelmChartsAndUpdate]
helm repo add open-telemetry https://open-telemetry.github.io/opentelemetry-helm-charts
helm repo update
# --8<-- [end:addOTELHelmChartsAndUpdate]

# Install Collector RBAC
# --8<-- [start:addCollectorRBAC]
kubectl apply -f collector-rbac.yaml
# --8<-- [end:addCollectorRBAC]

# Install Collector
# --8<-- [start:installCollector]
helm upgrade -i dynatrace-collector open-telemetry/opentelemetry-collector -f collector-values.yaml
# --8<-- [end:installCollector]

# Wait for pods
# --8<-- [start:waitForPodsReadyDefaultNS]
kubectl wait --for=condition=Ready pod --all --timeout=10m
# --8<-- [end:waitForPodsReadyDefaultNS]

# Install OTEL Demo
# --8<-- [start:installOTELDemo]
helm upgrade -i my-otel-demo open-telemetry/opentelemetry-demo -f otel-demo-values.yaml
# --8<-- [end:installOTELDemo]

# Port forward to 8080
# --8<-- [start:portForwardFEP8080]
kubectl -n default port-forward svc/my-otel-demo-frontendproxy 8080:8080
# --8<-- [end:portForwardFEP8080]
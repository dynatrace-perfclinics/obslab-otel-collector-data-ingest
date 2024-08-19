## Create a Kubernetes secret

Use `kubectl` to create a `Secret` to store your Dynatrace connection details.

Substitute your values into the following command and execute it.

Change `abc12345` to your environment ID and change `dt0c01.sample.secret` to the value of your API token (generated above).

Note: Do not change the name. Leave as `dynatrace-otelcol-dt-api-credentials`

```
kubectl create secret generic dynatrace-otelcol-dt-api-credentials \
--from-literal=DT_ENDPOINT=https://abc12345.live.dynatrace.com/api/v2/otlp \
--from-literal=DT_API_TOKEN=dt0c01.sample.secret
```

You should see this: `secret/dynatrace-otelcol-dt-api-credentials created`

## Add OpenTelemetry Helm charts and Update

Copy and paste the following to add the OpenTelemetry Helm chart and update it to the latest versions.

```
helm repo add open-telemetry https://open-telemetry.github.io/opentelemetry-helm-charts
helm repo update
```

## Configure and Install Dynatrace OpenTelemetry Collector

The OpenTelemetry collector requires a configuration file.

This is already available in the environment. See [collector-values.yaml](https://github.com/dynatrace-perfclinics/obslab-otel-collector-data-ingest/blob/main/collector-values.yaml){target=_blank}

You do not need to modify this file.

Install the collector by copy and pasting this content:

```
helm upgrade -i dynatrace-collector open-telemetry/opentelemetry-collector -f collector-values.yaml
```

After Helm indicates it has installed, run the following command and you should see a pod either `Pending` or `Running`.

```
kubectl get pods
```

Wait and periodically re-run `kubectl get pods` until the Pod is `Running`.

## Install OpenTelemetry Demo

Use Helm to install the OpenTelemetry demo system, passing the configuration file (already created for you - see [otel-demo-values.yaml](https://github.com/dynatrace-perfclinics/obslab-otel-collector-data-ingest/blob/main/otel-demo-values.yaml){target=_blank}).

This is a demo website we will use to generate OpenTelemetry data (logs, metrics and traces).

```
helm upgrade -i my-otel-demo open-telemetry/opentelemetry-demo -f otel-demo-values.yaml
```

The Pods may take 2-3 minutes to start, but running `kubectl get pods` should eventually show the pods running.

## [Click Here to Continue...](access-ui.md)
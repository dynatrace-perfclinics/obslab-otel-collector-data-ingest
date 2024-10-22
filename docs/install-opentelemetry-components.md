## Create a Kubernetes secret

Use `kubectl` to create a `Secret` to store your Dynatrace connection details.

Substitute your values into the following command and execute it.

Change `abc12345` to your environment ID and change `dt0c01.sample.secret` to the value of your API token (generated above).

Note: Do not change the name. Leave as `dynatrace-otelcol-dt-api-credentials`

```
--8<-- "snippets/commands.sh:createSecret"
```

You should see this: `secret/dynatrace-otelcol-dt-api-credentials created`

## Add OpenTelemetry Helm charts and Update

Copy and paste the following to add the OpenTelemetry Helm chart and update it to the latest versions.

```
--8<-- "snippets/commands.sh:addOTELHelmChartsAndUpdate"
```

## Configure and Install Dynatrace OpenTelemetry Collector

Create RBAC roles and role bindings so that the collector (which you will install next) can retrieve topology metadata information from the Kubernetes API:

```
--8<-- "snippets/commands.sh:addCollectorRBAC"
```

The OpenTelemetry collector requires a configuration file.

This is already available in the environment. See [collector-values.yaml](https://github.com/dynatrace-perfclinics/obslab-otel-collector-data-ingest/blob/main/collector-values.yaml){target=_blank}

You do not need to modify this file.

Install the collector by copy and pasting this content:

```
--8<-- "snippets/commands.sh:installCollector"
```

After Helm indicates it has installed, run the following command and wait until both pods are `Ready`.

```
--8<-- "snippets/commands.sh:waitForPodsReadyDefaultNS"
```

## Install OpenTelemetry Demo

Use Helm to install the OpenTelemetry demo system, passing the configuration file (already created for you - see [otel-demo-values.yaml](https://github.com/dynatrace-perfclinics/obslab-otel-collector-data-ingest/blob/main/otel-demo-values.yaml){target=_blank}).

This is a demo website we will use to generate OpenTelemetry data (logs, metrics and traces).

```
--8<-- "snippets/commands.sh:installOTELDemo"
```

Again wait for all pods to start up:

```
--8<-- "snippets/commands.sh:waitForPodsReadyDefaultNS"
```

<div class="grid cards" markdown>
- [Click Here to Continue :octicons-arrow-right-24:](access-ui.md)
</div>
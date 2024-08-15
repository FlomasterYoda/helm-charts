# common-chart

This Helm chart is used for deploying ConfigMaps with custom labels and data.

## Values

| Key                 | Type   | Default       | Description                           |
| ------------------- | ------ | ------------- | ------------------------------------- |
| `name`              | string | `nil`         | Name for the ConfigMap.               |
| `labels`            | object | `{}`          | Custom labels to apply to ConfigMap.  |
| `data`              | list   | `[]`          | List of ConfigMap definitions.        |
| `data[].name`       | string | `nil`         | Name of the ConfigMap.                |
| `data[].configmaps` | object | `{}`          | Data to include in the ConfigMap.     |

### Example

This example shows how to define multiple ConfigMaps with different names and data:

```yaml
name: "my-app"
labels:
  app: "my-app"
  env: "production"

data:
  - name: "config-1"
    configmaps:
      key1: value1
      key2: value2
  - name: "config-2"
    configmaps:
      key3: value3
      key4: value4
```
# Helm Chart for CronJobs

This Helm chart allows you to deploy CronJobs with customizable settings including environment variables, resources, volumes, and more.

## Values

The following table lists the configurable parameters of the chart and their default values.

| Key                                  | Type    | Default                             | Description |
| ------------------------------------ | ------- | ----------------------------------- | ----------- |
| `labels`                             | object  | `{}`                                | Common labels applied to resources. |
| `cronJobDefaults`                    | object  | `{}`                                | Default settings for all CronJobs.  |
| `cronJobDefaults.env`                | list    | `[]`                                | Default environment variables.      |
| `cronJobDefaults.envFrom`            | list    | `[]`                                | Default environment variables from secrets or configmaps. |
| `cronJobDefaults.resources`          | object  | `{}`                                | Default resource requests and limits. |
| `cronJobDefaults.volumes`            | list    | `[]`                                | Default volume mounts.              |
| `cronJobDefaults.serviceAccount.name`| string  | `nil`                               | Default service account name.       |
| `serviceAccount.name`                | string  | `nil`                               | Service account name for CronJobs.  |
| `secrets`                            | list    | `[]`                                | Secrets to be used as environment variables. |
| `jobs`                               | list    | `[]`                                | List of CronJobs.                   |
| `jobs[].name`                        | string  | `nil`                               | Name of the CronJob.                |
| `jobs[].schedule`                    | string  | `nil`                               | Cron schedule for the job.          |
| `jobs[].concurrencyPolicy`           | string  | `nil`                               | Concurrency policy for the job.     |
| `jobs[].failedJobsHistoryLimit`      | int     | `nil`                               | Number of failed jobs to retain.    |
| `jobs[].backoffLimit`                | int     | `nil`                               | Number of retries before marking a job as failed. |
| `jobs[].activeDeadlineSeconds`       | int     | `nil`                               | Maximum time before a job is terminated. |
| `jobs[].image.pullSecret`            | string  | `nil`                               | Secret for pulling the job's image. |
| `jobs[].image.pullPolicy`            | string  | `"IfNotPresent"`                    | Image pull policy.                  |
| `jobs[].command`                     | list    | `[]`                                | Command to run in the job's container. |
| `jobs[].args`                        | list    | `[]`                                | Arguments for the job's container.  |
| `jobs[].resources`                   | object  | `{}`                                | Resource requests and limits.       |
| `jobs[].volumes`                     | list    | `[]`                                | Volumes to be mounted in the container. |
| `jobs[].env`                         | list    | `[]`                                | Environment variables for the job.  |
| `jobs[].envFrom`                     | list    | `[]`                                | Environment variables from secrets or configmaps. |
| `jobs[].nodeSelector`                | object  | `{}`                                | Node selector for the job.          |
| `jobs[].affinity`                    | object  | `{}`                                | Affinity rules for scheduling the job. |
| `jobs[].tolerations`                 | list    | `[]`                                | Tolerations for scheduling the job. |
| `jobs[].restartPolicy`               | string  | `"Never"`                           | Restart policy for the job's containers. |
| `jobs[].useDefaultEnvs`              | bool    | `false`                             | Whether to use default environment variables. |
| `jobs[].useDefaultEnvsFrom`          | bool    | `false`                             | Whether to use default envFrom variables. |
| `jobs[].useDefaultResources`         | bool    | `false`                             | Whether to use default resources.   |
| `jobs[].useDefaultVolumes`           | bool    | `false`                             | Whether to use default volumes.     |
| `jobs[].useServiceAccount`           | bool    | `false`                             | Whether to use a service account.   |
| `jobs[].securityContext.runAsUser`   | int     | `nil`                               | User ID for the job's container.    |
| `jobs[].securityContext.runAsGroup`  | int     | `nil`                               | Group ID for the job's container.   |
| `jobs[].securityContext.fsGroup`     | int     | `nil`                               | File system group for the job's container. |
| `jobs[].successfulJobsHistoryLimit`  | int     | `nil`                               | Number of successful jobs to retain. |

## Example

Here is an example of how to define a CronJob:

```yaml
name: "my-cronjob"
schedule: "0 0 * * *"
image:
  repository: "my-repo/my-image"
  tag: "latest"
  pullSecret: "my-pull-secret"
jobs:
  - name: "job1"
    useDefaultEnvs: true
    useServiceAccount: true
    command:
      - "echo"
    args:
      - "Hello, World!"
    nodeSelector:
      disktype: ssd
    affinity:
      nodeAffinity:
        requiredDuringSchedulingIgnoredDuringExecution:
          nodeSelectorTerms:
            - matchExpressions:
                - key: disktype
                  operator: In
                  values:
                    - ssd
    tolerations:
      - key: "key1"
        operator: "Equal"
        value: "value1"
        effect: "NoExecute"
    resources:
      limits:
        cpu: "100m"
        memory: "128Mi"
```

# Helm Chart for Services

This Helm chart allows you to deploy Kubernetes services with customizable settings including ports, annotations, session affinity, and more.

## Values

The following table lists the configurable parameters of the chart and their default values.

| Key                                           | Type      | Default       | Description |
| --------------------------------------------- | --------- | ------------- | ----------- |
| `labels`                                      | object    | `{}`          | Common labels applied to resources. |
| `deployments`                                 | list      | `[]`          | List of deployments and their configurations. |
| `deployments[].service`                       | object    | `nil`         | Service configuration for the deployment. |
| `deployments[].service.name`                  | string    | `nil`         | Name of the service. |
| `deployments[].service.annotations`           | object    | `{}`          | Annotations for the service. |
| `deployments[].service.clusterIP`             | string    | `nil`         | Cluster IP for the service. |
| `deployments[].service.externalIPs`           | list      | `[]`          | External IPs for the service. |
| `deployments[].service.externalName`          | string    | `nil`         | External name for ExternalName service type. |
| `deployments[].service.externalTrafficPolicy` | string    | `nil`         | External traffic policy for the service. |
| `deployments[].service.healthCheckNodePort`   | int       | `nil`         | Health check node port for the service. |
| `deployments[].service.ipFamily`              | string    | `nil`         | IP family for the service. |
| `deployments[].service.loadBalancerIP`        | string    | `nil`         | Load balancer IP for the service. |
| `deployments[].service.loadBalancerSourceRanges` | list    | `[]`          | Source ranges for load balancer service. |
| `deployments[].service.publishNotReadyAddresses` | bool    | `false`       | Whether to publish not ready addresses for the service. |
| `deployments[].service.sessionAffinity`       | string    | `nil`         | Session affinity for the service. |
| `deployments[].service.sessionAffinityConfig` | object    | `{}`          | Configuration for session affinity. |
| `deployments[].service.topologyKeys`          | list      | `[]`          | Topology keys for the service. |
| `deployments[].service.ports`                 | list      | `[]`          | Ports configuration for the service. |
| `deployments[].service.ports[].name`          | string    | `nil`         | Name of the port. |
| `deployments[].service.ports[].port`          | int       | `nil`         | Port number for the service. |
| `deployments[].service.ports[].containerPort` | int       | `nil`         | Container port number. |
| `deployments[].service.ports[].nodePort`      | int       | `nil`         | Node port number for NodePort service type. |
| `deployments[].service.ports[].protocol`      | string    | `"TCP"`       | Protocol for the service port. |
| `deployments[].service.selector`              | object    | `{}`          | Selector for the service. |
| `deployments[].service.type`                  | string    | `"ClusterIP"` | Type of the service (ClusterIP, NodePort, LoadBalancer, ExternalName). |

## Example

Here is an example of how to define a service:

```yaml
deployments:
  - service:
      name: "my-service"
      type: "LoadBalancer"
      annotations:
        cloud.google.com/load-balancer-type: "Internal"
      ports:
        - name: "http"
          port: 80
          containerPort: 8080
      selector:
        app: "my-app"
```

# Helm Chart for ServiceAccounts

This Helm Chart allows you to deploy a Kubernetes ServiceAccount with custom labels and annotations.

## Values

The following table lists the configurable parameters of this chart and their default values.

| Key                                | Type   | Default | Description                                            |
| ---------------------------------- | ------ | ------- | ------------------------------------------------------ |
| `labels`                           | object | `{}`    | General labels applied to all resources.               |
| `serviceAccounts`                  | list   | `[]`    | List of ServiceAccounts and their configurations.      |
| `serviceAccounts[].name`           | string | `nil`   | Name of the ServiceAccount.                            |
| `serviceAccounts[].annotations`    | object | `{}`    | Annotations for the ServiceAccount.                    |

## Examlpe

Here is an example of a ServiceAccount configuration:

```yaml
serviceAccounts:
  - name: "my-service-account"
    annotations:
      iam.gke.io/gcp-service-account: "my-service-account@my-project.iam.gserviceaccount.com"
```

# Helm Chart for PersistentVolumeClaims

This Helm Chart allows you to deploy PersistentVolumeClaims (PVC) with custom labels, StorageClass, volume mode, and other parameters.

## Values

The following table lists the configurable parameters of this chart and their default values.

| Key                                  | Type   | Default       | Description                                            |
| ------------------------------------ | ------ | ------------- | ------------------------------------------------------ |
| `labels`                             | object | `{}`          | General labels that apply to all resources.            |
| `volumes`                            | list   | `[]`          | A list of PVC and their configurations.                |
| `volumes[].name`                     | string | `nil`         | The name of the PersistentVolumeClaim.                 |
| `volumes[].storageClassName`         | string | `nil`         | The StorageClass name of the PersistentVolumeClaim.    |
| `volumes[].volumeMode`               | string | `nil`         | The volume mode (e.g. Filesystem or Block).            |
| `volumes[].volumeName`               | string | `nil`         | The name of an existing volume to use.                 |
| `volumes[].dataSource`               | object | `nil`         | The data source for the volume (e.g. VolumeSnapshot).  |
| `volumes[].accessModes`              | list   | `["ReadWriteOnce"]` | Volume Access Mods (ReadWriteOnce, ReadOnlyMany) |
| `volumes[].size`                     | string | `nil`         | Volume size                                            |

## Examlpe

Here is an example of a PersistentVolumeClaim configuration:

```yaml
volumes:
  - name: "my-pvc"
    storageClassName: "fast-storage"
    volumeMode: "Filesystem"
    accessModes:
      - ReadWriteMany
    size: "10Gi"
```
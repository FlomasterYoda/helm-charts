# common-chart

This Helm chart provides a flexible and customizable way to deploy various Kubernetes resources, including Deployments, CronJobs, Services, ServiceAccounts, and PersistentVolumeClaims. It's designed to simplify the process of deploying and managing complex applications in Kubernetes environments.

#### Minimum Values

| Key                         | Type   | Default | Description                |
|-----------------------------|--------|---------|----------------------------|
| `name`                      | string | `nil`   | Name for the App.          |
| `labels`                    | object | `{}`    | Custom labels.             |
| `image.version`             | string | `nil`   | Image tag or version.      |
| `eks`                       | list   | `[]`    | Default eks configuration. |
| `eks.image`                 | object | `{}`    | EKS image configuration.   |
| `eks.image.repository`      | string  | `nil`   | EKS image repo.           |
| `eks.image.imagePullPolicy` | string  | `nil`   | EKS image pull policy.    |

#### Example for Minimum Values

This example shows how to define minimum expected configuration:

```yaml
name: dev-app
####################### Image Version #######################
image:
  version: latest
####################### EKS #######################
eks:
  image: 
    repository: 111111111111.dkr.ecr.us-west-2.amazonaws.com/dev-app
    imagePullPolicy: IfNotPresent
```

## Components

### ConfigMaps
ConfigMaps allow you to decouple configuration artifacts from image content to keep containerized applications portable.

This Helm chart is used for deploying ConfigMaps with custom labels and data.

#### Values

| Key                   | Type   | Default       | Description                           |
| --------------------- | ------ | ------------- | ------------------------------------- |
| `configmaps`          | list   | `[]`          | List of ConfigMap definitions.        |
| `configmaps[].name`   | string | `nil`         | Name of the ConfigMap.                |
| `configmaps[].labels` | object | `{}`          | Custom labels to apply to ConfigMap.  |
| `configmaps[].data`   | object | `{}`          | Data to include in the ConfigMap.     |

#### Example for ConfigMaps

This example shows how to define multiple ConfigMaps with different names and data:

```yaml
configmaps:
  - name: dev-app
    labels: 
      app: dev-app
    data: 
      APP_ENV: qa
      APP_PROJECT: dev-app1
  - name: dev-app-2
    labels: 
      app: dev-app-2
    data: 
      APP_ENV: qa
      APP_PROJECT: dev-app2
```
### CronJobs

CronJobs are useful for creating periodic and recurring tasks, like running backups or sending emails.

This Helm chart allows you to deploy CronJobs with customizable settings including environment variables, resources, volumes, and more.

#### Values

The following table lists the configurable parameters of the chart and their default values. The default values ​​can be changed by adding parameters to cronJobDefaults.

| Key                                            | Type   | Default          | Description                                               |
|------------------------------------------------|--------|------------------|-----------------------------------------------------------|
| `cronJobDefaults`                              | object | `{}`             | Default settings for all CronJobs.                        |
| `cronJobDefaults.env`                          | list   | `[]`             | Default environment variables.                            |
| `cronJobDefaults.envFrom`                      | list   | `[]`             | Default environment variables from secrets or configmaps. |
| `cronJobDefaults.resources`                    | object | `{}`             | Default resource requests and limits.                     |
| `cronJobDefaults.volumes`                      | list   | `[]`             | Default volume mounts.                                    |
| `cronJobDefaults.failedJobsHistoryLimit`       | int    | `nil`            | Default number of failed jobs to retain.                  |
| `cronJobDefaults.successfulJobsHistoryLimit`   | int    | `nil`            | Default number of successful jobs to retain.              |
| `cronJobDefaults.concurrencyPolicy`            | string | `nil`            | Default concurrency policy for the job.                   |
| `cronJobDefaults.suspend`                      | bool   | `false`          | Default suspend execution of Jobs for a CronJob.          |
| `cronJobDefaults.restartPolicy`                | string | `"OnFailure"`    | Default restart policy for the job's containers.          |
| `cronJobDefaults.env`                          | list   | `[]`             | Default environment variables for the job.                |
| `cronJobDefaults.envVarValuesFrom`             | list   | `[]`             | Default environment variables from Pod-level fields.      |
| `cronJobDefaults.envFrom`                      | list   | `[]`             | Default environment variables from secrets or configmaps. |
| `jobs`                                         | list   | `[]`             | List of CronJobs.                                         |
| `jobs[].name`                                  | string | `nil`            | Name of the CronJob.                                      |
| `jobs[].jobLabels`                             | object | `{}`             | Labels for the CronJob.                                   |
| `jobs[].annotations`                           | object | `{}`             | Annotations for the CronJob.                              |
| `jobs[].pod_annotations`                       | object | `{}`             | Annotations for the Pod.                                  |
| `jobs[].schedule`                              | string | `nil`            | Cron schedule for the job.                                |
| `jobs[].concurrencyPolicy`                     | string | `nil`            | Concurrency policy for the job.                           |
| `jobs[].failedJobsHistoryLimit`                | int    | `nil`            | Number of failed jobs to retain.                          |
| `jobs[].backoffLimit`                          | int    | `nil`            | Number of retries before marking a job as failed.         |
| `jobs[].activeDeadlineSeconds`                 | int    | `nil`            | Maximum time before a job is terminated.                  |
| `jobs[].image.pullSecret`                      | string | `nil`            | Secret for pulling the job's image.                       |
| `jobs[].image.pullPolicy`                      | string | `"IfNotPresent"` | Image pull policy.                                        |
| `jobs[].command`                               | list   | `[]`             | Command to run in the job's container.                    |
| `jobs[].args`                                  | list   | `[]`             | Arguments for the job's container.                        |
| `jobs[].resources`                             | object | `{}`             | Resource requests and limits.                             |
| `jobs[].volumes`                               | list   | `[]`             | Volumes to be mounted in the container.                   |
| `jobs[].env`                                   | list   | `[]`             | Environment variables for the job.                        |
| `jobs[].envVarValuesFrom`                      | list   | `[]`             | Environment variables from Pod-level fields.              |
| `jobs[].envFrom`                               | list   | `[]`             | Environment variables from secrets or configmaps.         |
| `jobs[].nodeSelector`                          | object | `{}`             | Node selector for the job.                                |
| `jobs[].affinity`                              | object | `{}`             | Affinity rules for scheduling the job.                    |
| `jobs[].tolerations`                           | list   | `[]`             | Tolerations for scheduling the job.                       |
| `jobs[].restartPolicy`                         | string | `"Never"`        | Restart policy for the job's containers.                  |
| `jobs[].useDefaultEnvs`                        | bool   | `false`          | Whether to use default environment variables.             |
| `jobs[].useDefaultEnvsFrom`                    | bool   | `false`          | Whether to use default envFrom variables.                 |
| `jobs[].useDefaulenvVarValuesFrom`             | bool   | `false`          | Whether to use default envVarValuesFrom variables.        |
| `jobs[].useDefaultResources`                   | bool   | `false`          | Whether to use default resources.                         |
| `jobs[].useDefaultVolumes`                     | bool   | `false`          | Whether to use default volumes.                           |
| `jobs[].useExternalSecrets`                    | bool   | `false`          | Whether to use external secrets.                          |
| `jobs[].suspend`                               | bool   | `false`          | suspend execution of Jobs for a CronJob.                  |
| `jobs[].serviceAccountName`                    | string | `nil`            | Service account name for the CronJob.                     |
| `jobs[].securityContext.runAsUser`             | int    | `nil`            | User ID for the job's container.                          |
| `jobs[].securityContext.runAsGroup`            | int    | `nil`            | Group ID for the job's container.                         |
| `jobs[].securityContext.fsGroup`               | int    | `nil`            | File system group for the job's container.                |
| `jobs[].successfulJobsHistoryLimit`            | int    | `nil`            | Number of successful jobs to retain.                      |

#### Example for Cronjobs

Here is an example of how to define a CronJob:

```yaml
jobs:
  - name: cj-dev-app
    concurrencyPolicy: Forbid
    failedJobsHistoryLimit: 5
    startingDeadlineSeconds: 3600
    schedule: "0 9 * * 1"
    suspend: true
    successfulJobsHistoryLimit: 5
    imagePullSecrets: dockerkey
    jobLabels: 
      app: cj-dev-app
      cron: generate-csv
    nodeSelector: 
      node-role.kubernetes.io: nodes
    annotations: 
        reloader.stakater.com/auto: 'true'
    envFrom: 
      - configMapRef:
          name: dev-app
    command: 
      - /usr/bin/php
    args: 
      - /www/vhosts/web/console.php
      - app:csv-generator
    resources: 
      limits:
        cpu: 200m
        memory: 250Mi
      requests:
        cpu: 150m
        memory: 150Mi
    volumes: 
      - name: dev-central
        mountPath: /sharedfolder/dev
        persistentVolumeClaim:
          claimName: dev-central-efs-claim
    restartPolicy: OnFailure
    useExternalSecrets: true
    useDefaultEnvs: true
    useDefaultEnvsFrom: true
    useDefaulenvVarValuesFrom: true
  - name: cj-dev-app-email
    concurrencyPolicy: Forbid
    failedJobsHistoryLimit: 5
    startingDeadlineSeconds: 3600
    schedule: "0 10 * * *"
    suspend: false
    successfulJobsHistoryLimit: 5
    imagePullSecrets: dockerkey
    jobLabels: 
      app: cj-dev-app-email
      cron: store-tag-email
    nodeSelector: 
      node-role.kubernetes.io: nodes
    annotations: 
        reloader.stakater.com/auto: 'true'
    envFrom: 
      - configMapRef:
          name: dev-app
    command: 
      - /usr/bin/php
    args: 
      - /www/vhosts/web/console.php
      - app:store-tag-email
    resources: 
      limits:
        cpu: 200m
        memory: 250Mi
      requests:
        cpu: 150m
        memory: 150Mi
    volumes: 
      - name: dev-central
        mountPath: /sharedfolder/dev
        persistentVolumeClaim:
          claimName: dev-central-efs-claim
    restartPolicy: OnFailure
    useExternalSecrets: true
    useDefaultEnvs: false
    useDefaultEnvsFrom: false
    useDefaulenvVarValuesFrom: false
    env:
      APP_ENV: qa
      APP_IS_PROD_MODE: 'false'
      APP_PROJECT: cj-dev-app-email
    envVarValuesFrom:
      - name: NODE_IP
        valueFrom:
          fieldRef:
            fieldPath: status.hostIP
      - name: DD_AGENT_HOST
        valueFrom:
          fieldRef:
            fieldPath: status.hostIP
    envFrom: 
      - configMapRef:
          name: cj-dev-app-email-01
```

### Services

Services define a logical set of Pods and a policy by which to access them.

This Helm chart allows you to deploy Kubernetes services with customizable settings including ports, annotations, session affinity, and more.

#### Values

The following table lists the configurable parameters of the chart and their default values.

| Key                                  | Type   | Default       | Description                                                            |
|--------------------------------------|--------|---------------|------------------------------------------------------------------------|
| `service`                            | list   | `[]`          | List of deployments and their configurations.                          |
| `service[].name`                     | string | `nil`         | Name of the service.                                                   |
| `service[].labels`                   | object | `{}`          | Labels for the service.                                                |
| `service[].annotations`              | object | `{}`          | Annotations for the service.                                           |
| `service[].clusterIP`                | string | `nil`         | Cluster IP for the service.                                            |
| `service[].externalIPs`              | list   | `[]`          | External IPs for the service.                                          |
| `service[].externalName`             | string | `nil`         | External name for ExternalName service type.                           |
| `service[].externalTrafficPolicy`    | string | `nil`         | External traffic policy for the service.                               |
| `service[].healthCheckNodePort`      | int    | `nil`         | Health check node port for the service.                                |
| `service[].ipFamily`                 | string | `nil`         | IP family for the service.                                             |
| `service[].loadBalancerIP`           | string | `nil`         | Load balancer IP for the service.                                      |
| `service[].loadBalancerSourceRanges` | list   | `[]`          | Source ranges for load balancer service.                               |
| `service[].publishNotReadyAddresses` | bool   | `false`       | Whether to publish not ready addresses for the service.                |
| `service[].sessionAffinity`          | string | `nil`         | Session affinity for the service.                                      |
| `service[].sessionAffinityConfig`    | object | `{}`          | Configuration for session affinity.                                    |
| `service[].topologyKeys`             | list   | `[]`          | Topology keys for the service.                                         |
| `service[].ports`                    | list   | `[]`          | Ports configuration for the service.                                   |
| `service[].ports[].name`             | string | `nil`         | Name of the port.                                                      |
| `service[].ports[].port`             | int    | `nil`         | Port number for the service.                                           |
| `service[].ports[].containerPort`    | int    | `nil`         | Container port number.                                                 |
| `service[].ports[].nodePort`         | int    | `nil`         | Node port number for NodePort service type.                            |
| `service[].ports[].protocol`         | string | `"TCP"`       | Protocol for the service port.                                         |
| `service[].selector`                 | object | `{}`          | Selector for the service.                                              |
| `service[].type`                     | string | `"ClusterIP"` | Type of the service (ClusterIP, NodePort, LoadBalancer, ExternalName). |

#### Example for Services

Here is an example of how to define a service:

```yaml
services:
  dev-app:
    name: dev-app
    type: ClusterIP
    labels: 
      app: dev-app
      chart: dev-app-1.0.0-stable-1111111
    selector: 
      app: dev-app
    ports: 
      - name: http
        port: 8080
        protocol: TCP
        targetPort: 80
      - name: https
        port: 443
        protocol: TCP
        targetPort: 80
```

### ServiceAccounts

ServiceAccounts provide an identity for processes that run in a Pod.

This Helm Chart allows you to deploy a Kubernetes ServiceAccount with custom labels and annotations.

#### Values

The following table lists the configurable parameters of this chart and their default values.

| Key                                | Type   | Default | Description                                            |
| ---------------------------------- | ------ | ------- | ------------------------------------------------------ |
| `serviceAccounts`                  | list   | `[]`    | List of ServiceAccounts and their configurations.      |
| `serviceAccounts[].labels`         | object | `{}`    | Labels specific to the ServiceAccount.                 |
| `serviceAccounts[].name`           | string | `nil`   | Name of the ServiceAccount.                            |
| `serviceAccounts[].annotations`    | object | `{}`    | Annotations for the ServiceAccount.                    |

#### Example for ServiceAccounts

Here is an example of a ServiceAccount configuration:

```yaml
serviceAccounts:
  - name: "dev-service-account"
    annotations:
      iam.gke.io/gcp-service-account: "eks.amazonaws.com/role-arn: arn:aws:iam::111111111111:role/app-dev"
```

### PersistentVolumeClaims

PersistentVolumeClaims are requests for storage by users that can be fulfilled by PersistentVolumes.

This Helm Chart allows you to deploy PersistentVolumeClaims (PVC) with custom labels, StorageClass, volume mode, and other parameters.

#### Values

The following table lists the configurable parameters of this chart and their default values. 

| Key                                  | Type   | Default       | Description                                            |
| ------------------------------------ | ------ | ------------- | ------------------------------------------------------ |
| `volumes`                            | list   | `[]`          | A list of PVC and their configurations.                |
| `volumes[].labels`                   | object | `{}`          | Labels specific to the PersistentVolumeClaim.          |
| `volumes[].name`                     | string | `nil`         | The name of the PersistentVolumeClaim.                 |
| `volumes[].storageClassName`         | string | `nil`         | The StorageClass name of the PersistentVolumeClaim.    |
| `volumes[].volumeMode`               | string | `nil`         | The volume mode (e.g. Filesystem or Block).            |
| `volumes[].volumeName`               | string | `nil`         | The name of an existing volume to use.                 |
| `volumes[].dataSource`               | object | `nil`         | The data source for the volume (e.g. VolumeSnapshot).  |
| `volumes[].accessModes`              | list   | `["ReadWriteOnce"]` | Volume Access Mods (ReadWriteOnce, ReadOnlyMany) |
| `volumes[].size`                     | string | `nil`         | Volume size                                            |

#### Example for PersistentVolumeClaims

Here is an example of a PersistentVolumeClaim configuration:

```yaml
volumes:
  dev-central-efs-claim:
    name: dev-central-efs-claim
    accessModes: 
      - ReadWriteMany
    storageClassName: dev-central
    storageSize: 5Gi
```


### Deployments

Deployments provide declarative updates for Pods and ReplicaSets.

This Helm Chart allows for your deployments.

#### Values

The following table lists the configurable parameters of this chart and their default values. The default values ​​can be changed by adding parameters to deploymentDefaults.

| Variable                                               | Type   | Default                | Description                                                               |
|--------------------------------------------------------|--------|------------------------|---------------------------------------------------------------------------|
| `deploymentDefaults.dnsPolicy`                         | string | `nil`                  | Default DNS policy for the deployment.                                    |
| `deploymentDefaults.strategy`                          | object | `{ type: "Recreate" }` | Default deployment strategy (e.g., RollingUpdate, Recreate).              |
| `deploymentDefaults.revisionHistoryLimit`              | int    | `10`                   | Default number of old ReplicaSets for this Deployment you want to retain. |
| `deploymentDefaults.restartPolicy`                     | string | `"Always"`             | Default restart policy for the containers.                                |
| `deploymentDefaults.terminationGracePeriodSeconds`     | int    | `10`                   | Default time before killing the pod.                                      |
| `deploymentDefaults.schedulerName`                     | string | `nil`                  | Default scheduler name which assigns Pods to Nodes.                       |
| `deploymentDefaults.nodeSelector`                      | object | `{}`                   | Default node selector for the deployment.                                 |
| `deploymentDefaults.containers.env`                    | list   | `[]`                   | Default environment variables for the container.                          |
| `deploymentDefaults.containers.envVarValuesFrom`       | list   | `[]`                   | Default environment variables from Pod-level fields.                      |
| `deploymentDefaults.containers.envFrom`                | array  | `[]`                   | Default sources of environment variables from ConfigMaps or Secrets.      |
| `deploymentDefaults.containers.resources`              | object | `{}`                   | Default resource requests and limits for the container.                   |
| `deploymentDefaults.containers.livenessProbe`          | object | `{}`                   | Default liveness probe configuration for the container.                   |
| `deploymentDefaults.containers.readinessProbe`         | object | `{}`                   | Default readiness probe configuration for the container.                  |
| `deploymentDefaults.containers.volumeMounts`           | array  | `[]`                   | List of volumes to mount into the container.                              |
| `deployments.name`                                     | string | `nil`                  | Name of the deployment.                                                   |
| `deployments.labels`                                   | object | `{}`                   | Labels specific to the deployment.                                        |
| `deployments.annotations`                              | object | `{}`                   | Annotations specific to the deployment.                                   |
| `deployments.pod_annotations`                          | object | `{}`                   | Annotations specific to the Pod.                                   |
| `deployments.replicas`                                 | int    | `1`                    | Number of replicas for the deployment.                                    |
| `deployments.strategy`                                 | object | `{ type: "Recreate" }` | Deployment strategy (e.g., RollingUpdate, Recreate).                      |
| `deployments.containers`                               | array  | `[]`                   | List of containers to be deployed.                                        |
| `deployments.nodeSelector`                             | object | `{}`                   | Node selector for the deployment.                                         |
| `deployments.tolerations`                              | array  | `[]`                   | Tolerations for the deployment.                                           |
| `deployments.affinity`                                 | object | `{}`                   | Affinity rules for the deployment.                                        |
| `deployments.dnsPolicy`                                | string | `nil`                  | DNS policy for the deployment.                                            |
| `deployments.schedulerName`                            | string | `nil`                  | Scheduler name which assigns Pods to Nodes.                               |
| `deployments.securityContext`                          | object | `{}`                   | Security context for the deployment.                                      |
| `deployments.serviceAccountName`                       | string | `nil`                  | Service Account name for the deployment.                                  |
| `deployments.hostNetwork`                              | bool   | `false`                | Whether the deployment should use the host's network.                     |
| `deployments.hostIPC`                                  | bool   | `false`                | Whether the deployment should use the host's IPC namespace.               |
| `deployments.hostPID`                                  | bool   | `false`                | Whether the deployment should use the host's PID namespace.               |
| `deployments.topologySpreadConstraints`                | array  | `[]`                   | Topology spread constraints for the deployment.                           |
| `deployments.revisionHistoryLimit`                     | int    | `10`                   | Number of old ReplicaSets for this Deployment you want to retain.         |
| `deployments.restartPolicy`                            | string | `"Always"`             | Restart policy for the containers.                                        |
| `deployments.terminationGracePeriodSeconds`            | int    | `10`                   | Time before killing the pod.                                              |
| `deployments.containers.name`                          | string | `"container-0"`        | Name of the container.                                                    |
| `deployments.containers.image.repository`              | string | `nil`                  | Image repository for the container.                                       |
| `deployments.containers.image.version`                 | string | `nil`                  | Image version for the container.                                          |
| `deployments.containers.image.imagePullPolicy`         | string | `"IfNotPresent"`       | Image pull policy for the container.                                      |
| `deployments.containers.ports`                         | array  | `[]`                   | List of ports to expose in the container.                                 |
| `deployments.containers.env`                           | list   | `[]`                   | Environment variables for the container.                                  |
| `deployments.containers.envVarValuesFrom`              | list   | `[]`                   | Environment variables from Pod-level fields.                              |
| `deployments.containers.envFrom`                       | array  | `[]`                   | Sources of environment variables from ConfigMaps or Secrets.              |
| `deployments.containers.resources`                     | object | `{}`                   | Resource requests and limits for the container.                           |
| `deployments.containers.livenessProbe`                 | object | `{}`                   | Liveness probe configuration for the container.                           |
| `deployments.containers.readinessProbe`                | object | `{}`                   | Readiness probe configuration for the container.                          |
| `deployments.containers.volumeMounts`                  | array  | `[]`                   | List of volumes to mount into the container.                              |
| `deployments.containers.useDefaultEnvs`                | bool   | `false`                | Whether to use default environment variables.                             |
| `deployments.containers.useDefaultEnvsFrom`            | bool   | `false`                | Whether to use default envFrom variables.                                 |
| `deployments.containers.useDefaulenvVarValuesFrom`     | bool   | `false`                | Whether to use default envVarValuesFrom variables.                        |
| `deployments.containers.useDefaultResources`           | bool   | `false`                | Whether to use default resources.                                         |
| `deployments.containers.useDefaultVolumes`             | bool   | `false`                | Whether to use default volumes.                                           |
| `deployments.containers.useExternalSecrets`            | bool   | `false`                | Whether to use external secrets.                                          |
| `deployments.initContainers`                           | array  | `[]`                   | List of init containers for the deployment.                               |
| `deployments.initContainers.name`                      | string | `"container-0"`        | Name of the inticontainer.                                                |
| `deployments.initContainers.image.repository`          | string | `nil`                  | Image repository for the inticontainer.                                   |
| `deployments.initContainers.image.version`             | string | `nil`                  | Image version for the inticontainer.                                      |
| `deployments.initContainers.image.imagePullPolicy`     | string | `"IfNotPresent"`       | Image pull policy for the inticontainer.                                  |
| `deployments.initContainers.ports`                     | array  | `[]`                   | List of ports to expose in the inticontainer.                             |
| `deployments.initContainers.env`                       | list   | `[]`                   | Environment variables for the inticontainer.                              |
| `deployments.initContainers.envVarValuesFrom`          | list   | `[]`                   | Environment variables from Pod-level fields.                              |
| `deployments.initContainers.envFrom`                   | array  | `[]`                   | Sources of environment variables from ConfigMaps or Secrets.              |
| `deployments.initContainers.resources`                 | object | `{}`                   | Resource requests and limits for the inticontainer.                       |
| `deployments.initContainers.livenessProbe`             | object | `{}`                   | Liveness probe configuration for the inticontainer.                       |
| `deployments.initContainers.readinessProbe`            | object | `{}`                   | Readiness probe configuration for the inticontainer.                      |
| `deployments.initContainers.volumeMounts`              | array  | `[]`                   | List of volumes to mount into the inticontainer.                          |
| `deployments.initContainers.useDefaultEnvs`            | bool   | `false`                | Whether to use default environment variables.                             |
| `deployments.initContainers.useDefaultEnvsFrom`        | bool   | `false`                | Whether to use default envFrom variables.                                 |
| `deployments.initContainers.useDefaulenvVarValuesFrom` | bool   | `false`                | Whether to use default envVarValuesFrom variables.                        |
| `deployments.initContainers.useDefaultResources`       | bool   | `false`                | Whether to use default resources.                                         |
| `deployments.initContainers.useDefaultVolumes`         | bool   | `false`                | Whether to use default volumes.                                           |
| `deployments.initContainers.useExternalSecrets`        | bool   | `false`                | Whether to use external secrets.                                          |

#### Example for Deployments

Here is an example of a Deployment configuration:

```yaml
deployments:
  dev-app:
    name: dev-app
    replicas: 1
    labels: 
      app: dev-app
      env: qa
    annotations: 
      reloader.stakater.com/auto: 'true'
    imagePullSecrets: dockerkey
    selector: 
      matchLabels:
        app: dev-app
    revisionHistoryLimit: 3
    strategy: 
      rollingUpdate:
        maxSurge: 25%
        maxUnavailable: 10%
      type: RollingUpdate
    dnsPolicy: ClusterFirst
    restartPolicy: Always
    terminationGracePeriodSeconds: 30
    schedulerName: default-scheduler
    containers:
      - name: dev-app
        command: 
          - /usr/bin/php
          - /www/vhosts/web/console.php
          - queues:daemons:event:category-updated
        resources: 
          limits:
            cpu: 200m
            memory: 250Mi
          requests:
            cpu: 150m
            memory: 150Mi
        useExternalSecrets: true
        useDefaultEnvs: false
        useDefaultEnvsFrom: false
        useDefaulenvVarValuesFrom: false
        env:
          NODE_ENV: qa
          APP_ACCESS_LOGGER_ENABLED: 'true'
          APP_LOGGER_ENABLED: 'true'
          APP_LOGGER_LEVEL: '1'          
        envVarValuesFrom: 
          - name: NODE_IP
            valueFrom:
              fieldRef:
                fieldPath: status.hostIP
          - name: DD_AGENT_HOST
            valueFrom:
              fieldRef:
                fieldPath: status.hostIP
        envFrom: 
          - configMapRef:
              name: dev-app
```

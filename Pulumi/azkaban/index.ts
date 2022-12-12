import * as k8s from '@pulumi/kubernetes';
import { GenerateLabels } from '../utils/generateLabels.util';
import { brokerNamespace, defaultNamespace } from '../utils/namespace.util';
import {LivenessCheck, ReadinessCheck} from "../utils/healthcheck.util";

const appName = 'azkaban';
const appLabels = GenerateLabels(appName, 'dev', '4.2.5', 'cicd', appName);
const kafkaUrl = btoa('kafka-kafka-brokers.' + brokerNamespace + ':9092');

const secret = new k8s.core.v1.Secret(appName + '-kafka', {
  metadata: {
    namespace: defaultNamespace,
    name: appName + '-kafka',
    labels: appLabels,
  },
  type: 'Opaque',
  data: {
    url: kafkaUrl,
  },
});

const deployment = new k8s.apps.v1.Deployment(appName + '-deployment', {
  metadata: {
    namespace: defaultNamespace,
    name: appName + '-deployment',
    labels: appLabels,
  },
  spec: {
    selector: {
      matchLabels: appLabels,
    },
    replicas: 1,
    template: {
      metadata: {
        labels: appLabels,
      },
      spec: {
        containers: [
          {
            name: appName,
            image: 'toxictoast/toxictv-azkaban:dev',
            imagePullPolicy: 'Always',
            env: [
              {
                name: 'PORT',
                value: '80',
              },
              {
                name: 'BROKER_URL',
                valueFrom: {
                  secretKeyRef: {
                    name: secret.metadata.name,
                    key: 'url',
                  },
                },
              },
            ],
            resources: {
              requests: {
                cpu: '300m',
                memory: '512Mi',
              },
            },
            readinessProbe: ReadinessCheck(true, 'api/health', 'HTTP'),
            livenessProbe: LivenessCheck(true, 'api/health', 'HTTP'),
          },
        ],
      },
    },
  },
});

const service = new k8s.core.v1.Service(appName + '-service', {
  metadata: {
    name: `${appName}-service`,
    namespace: defaultNamespace,
    labels: appLabels,
  },
  spec: {
    selector: appLabels,
    type: 'ClusterIP',
    ports: [
      {
        name: 'http',
        port: 80,
        targetPort: 80,
        protocol: 'TCP',
      },
    ],
  },
});

export const azkaban = {
  deploymentId: deployment.id,
  deploymentName: deployment.metadata.name,
  deploymentStatus: deployment.status,
  deploymentNameSpace: deployment.metadata.namespace,
  serviceId: service.id,
  serviceName: service.metadata.name,
  serviceStatus: service.status,
  serviceNameSpace: service.metadata.namespace,
  secretMapId: secret.id,
  secretMapName: secret.metadata.name,
  secretMapNameSpace: secret.metadata.namespace,
};

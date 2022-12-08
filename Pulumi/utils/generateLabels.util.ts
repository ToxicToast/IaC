export function GenerateLabels(
  name: string,
  instance: string,
  version: string,
  component: string,
  app: string
): { [key: string]: string } {
  return {
    'app.kubernetes.io/name': name,
    'app.kubernetes.io/instance': instance,
    'app.kubernetes.io/version': version,
    'app.kubernetes.io/component': component,
    'app.kubernetes.io/part-of': 'toxictv',
    app: app,
  };
}

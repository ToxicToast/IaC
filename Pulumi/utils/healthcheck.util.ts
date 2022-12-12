export function ReadinessCheck(enabled: boolean, path: string, scheme: string) {
    return {
        enabled,
        path,
        scheme,
        initialDelaySeconds: 30,
        periodSeconds: 10,
        timeoutSeconds: 5,
        failureThreshold: 6,
        successThreshold: 1,
    };
}

export function LivenessCheck(enabled: boolean, path: string, scheme: string) {
    return {
        enabled,
        path,
        scheme,
        initialDelaySeconds: 120,
        periodSeconds: 10,
        timeoutSeconds: 5,
        failureThreshold: 6,
        successThreshold: 1,
    };
}
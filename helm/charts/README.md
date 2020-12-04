# Helm Charts

## Introduction

This folder includes kubernetes [Charts](./charts) and the custom configuration in partner specific folders that is specific to a deployment. The custom configuration overrides the default values on specific Charts.

To learn more about [Helm](https://helm.sh/) see [Helm Docs](https://helm.sh/docs/).

## Installing Helm

> Note: the Helm binary can be installed using a bunch of package managers. Check first if your preferred package manager distributes it and install it from there before trying to manually install it.

To manually install Helm, run the following commands:

```sh
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
```

## Creating a Chart

To create a Chart named `crunch`:

```bash
helm create charts/crunch
```

This command creates the `crunch` Helm Chart in the `helm/charts` folder.

## Installing and Upgrading a Chart

To install the Chart `crunch`:

```bash
helm upgrade --values=helm/releases/mango.dev.k8s.onalabs.org/default/crunch/vaules.yaml --install crunch ./helm/charts/crunch
```

## Testing a Chart

Test your release:

```bash
helm test crunch
```

### Make sure your Chart is linted

Use the `helm lint` command to lint your Chart.

```bash
helm lint helm/charts/crunch
```

To Learn more about testing and writing tests see [Helm Chart Tests](https://helm.sh/docs/topics/chart_tests/).

## Lessons

There are [lessons](./FAQ.md) learned while starting on Kubernetes and Helm. Document each lesson in the [FAQ.md](./FAQ.md).

## Installing the cert-manager

[cert-manager](https://cert-manager.io/docs/) is a native Kubernetes certificate management controller. It can be installed with helm, see full instructions [here](https://cert-manager.io/docs/installation/kubernetes/). There should be only one cert-manager per Kubernetes cluster, more than one could result in unexpected issues for example being blocked by lets encrypt or being unable to issue certificates. You should delete existing cert-manager CRDs if you have an existing faulty setup.

Create the namespace for cert-manager.

```console
kubectl create namespace cert-manager
```

Add the jetstack Helm repository and update your chart repository cache.

```console
helm repo add jetstack https://charts.jetstack.io
helm repo update
```

Install cert-manager with CRDs.

```console
 helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --version v0.15.1 \
  --set installCRDs=true
```

Or

```console
 helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --version v0.15.1 \
  --values=helm/releases/mango.dev.k8s.onalabs.org/cert-manager/values.yml
```

Verify the installation, you should have `cert-manager`, `cert-manager-cainjector` and `cert-manager-webhook` pods running.

```console
kubectl get pods --namespace cert-manager
NAME                                       READY   STATUS    RESTARTS   AGE
cert-manager-9b8969d86-vkl9h               1/1     Running   0          72m
cert-manager-cainjector-8545fdf87c-fbkh9   1/1     Running   0          72m
cert-manager-webhook-8c5db9fb6-bgvxq       1/1     Running   0          72m
```

### Configure and create LetsEncrypt ClusterIssuer

You need to create your first [issuer](https://cert-manager.io/docs/configuration/) in order to issue certificates. It is advised you test with staging issuer before trying on production issuer.

```console
kubectl create -f helm/releases/mango.dev.k8s.onalabs.org/staging-clusterissuer-letsencrypt-staging.yaml
kubectl create -f helm/releases/mango.dev.k8s.onalabs.org/production-clusterissuer-letsencrypt-production.yaml
```

### Configure your Chart ingress to use the ClusterIssuers configured above

You ingress should have values below:

```yaml
ingress:
  # Enable an ingress
  enabled: true
  annotations:
    # Use the Nginx ingress controller
    kubernetes.io/ingress.class: nginx
    # Enable tls-acme e.g. LetsEncrypt
    kubernetes.io/tls-acme: "true"
    # specify the cluster-issuer
    cert-manager.io/cluster-issuer: "letsencrypt-staging"
    # Validate acme challenge requests over http
    cert-manager.io/acme-challenge-type: http01
  hosts:
      # change domain to match your service
    - host: demo.example.com
      paths: ["/"]
  tls:
    # change the secret name
    - secretName: demo-example-com-tls
      hosts:
        # change domain to match your service
        - demo.example.com
```

Once you `helm install` your service you should have a certificate ready attached to your service which will by default be redirected to https.

```console
kubectl get certificate
NAME                    READY   SECRET                  AGE
demo-example-com-tls    True    demo-example-com-tls   60m
```

You can see the certificate details with the command `kubectl describe certificate`.

**Tip**: Check the cert-manager pod for any debug information incase you are having challenges with SSL certificates. Use the `kubectl log` command e.g.

```console
kubectl logs -f -n cert-manager cert-manager-9b8969d86-vkl9h
```

## Managing Secrets

Use [helm-secrets](https://github.com/zendesk/helm-secrets) to encrypt secrets you want tracked using Git. To install the helm-secrets plugin, run:

```sh
helm plugin install https://github.com/zendesk/helm-secrets
```

Depending on your Operating System, you might get the following error when a hook tries to install [Mozilla SOPS](https://github.com/mozilla/sops):

```console
mv: cannot create regular file ‘/usr/local/bin/sops’: Permission denied
Error: plugin install hook for “secrets” exited with error
```

If you get this error, you might have to install SOPS independently using your package manager or download the binary from [here](https://github.com/mozilla/sops#stable-release).

Once you have the helm-secrets plugin installed, you can encrypt Helm secrets by running the following command from the root directory of this repo:

```sh
helm secrets enc <path to file>
```

Deploying Helm releases with secret is done a bit differently:

```sh
helm secrets upgrade --install <name of release> <Helm repository> -f <path to values file e.g. helm/releases/ops.prod.k8s.onalabs.org/default/kamus/values.yaml> -f <path to secrets file helm/releases/ops.prod.k8s.onalabs.org/default/kamus/secrets.yaml>
```

SOPS uses the [.sops.yaml](../.sops.yaml) configuration file to figure out which AWS KMS key to use to encrypt files. Your AWS user/role needs to have access to the configured KMS key to be able to encrypt and decrypt files. If you get the following error, ask the SRE team to give you access to the key:

```console
Could not generate data key: [failed to encrypt new data key with master key “arn:aws:kms:eu-west-1:534***385:key/620b89fe-8365–45a6-aad6–25b435611e8b”: Failed to call KMS encryption service: AccessDeniedException:
status code: 400, request id: 699332aa-492b-47b4-b9ab-50f83dbcc2a4]
Error: plugin “secrets” exited with error
```

# Flux HelloWorld

This example demostrate how to install and configure Flux and Helm Operator on AKS cluter.

In this example, we are deploying `Istio`, `Nginx Ingress`, `Weavescope` with FluxCD.

## Prerequisite (Optional)

To setup a new AKS cluster on Azure, simple execute the launch-pad, it will create a new resources group and a new aks cluster.

```sh
./launch aks
```

To connect to your cluster using `kubectl`, run the following command (replace your-rg and your-aks with your resources group and aks name)

```sh
az aks get-credentials --resource-group <your-rg> --name <your-aks>
```

## QuickStart (Get started with Flux using Helm)

Create the fluxcd namespace:

```sh
kubectl create ns fluxcd
```

Install Flux by specifying your fork URL (replace fluxcd with your GitHub username):

```sh
helm upgrade -i flux fluxcd/flux --wait \
--namespace fluxcd \
--set registry.pollInterval=1m \
--set git.pollInterval=1m \
--set git.url=git@github.com:melvinlee/flux-helloworld
```

Install the HelmRelease Kubernetes custom resource definition:

```sh
kubectl apply -f https://raw.githubusercontent.com/fluxcd/helm-operator/master/deploy/crds.yaml
```

Install Flux Helm Operator with Helm v3 support:

```sh
helm upgrade -i helm-operator fluxcd/helm-operator --wait \
--namespace fluxcd \
--set git.ssh.secretName=flux-git-deploy \
--set helm.versions=v3
```
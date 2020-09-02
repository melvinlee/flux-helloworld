# Flux HelloWorld

This example demostrate how to install and configure Flux and Helm Operator on AKS cluter.

In this example, we are deploying `Istio`, `Nginx Ingress`, `Weavescope`, etc with FluxCD.

This config has the following folder structure.

```sh
.
├── README.md
├── launch.config
├── launch.sh
├── namespaces
│   ├── ingress.yaml
│   ├── istio-system.yaml
│   ├── monitoring.yaml
│   └── weavescope.yaml
├── releases
│   ├── grafana.yaml
│   ├── nginx-ingress.yaml
│   ├── prometheus.yaml
│   └── weavescope.yaml
└── workloads
    ├── istio-controlplane.yaml
    ├── istio-operator.yaml
    └── ms-agentconfig.yaml
```

Inside the release directory there are HelmRelease defination.

The workloads directory contain workload for the chart that we deployed or additional resources to be deployed.


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

1. Create the fluxcd namespace:

```sh
kubectl create ns fluxcd
```

2. Add FluxCD repository:

```sh
helm repo add fluxcd https://charts.fluxcd.io
```

3. Install Flux by specifying your fork URL (replace fluxcd with your GitHub username):

```sh
helm upgrade -i flux fluxcd/flux --wait \
--namespace fluxcd \
--set registry.pollInterval=1m \
--set git.pollInterval=1m \
--set syncGarbageCollection.enabled=true \
--set git.readonly=true \
--set git.url=git@github.com:melvinlee/flux-helloworld
```

4. Install the HelmRelease Kubernetes custom resource definition:

```sh
kubectl apply -f https://raw.githubusercontent.com/fluxcd/helm-operator/master/deploy/crds.yaml
```

5. Install Flux Helm Operator with Helm v3 support:

```sh
helm upgrade -i helm-operator fluxcd/helm-operator --wait \
--namespace fluxcd \
--set git.ssh.secretName=flux-git-deploy \
--set helm.versions=v3
```

6. Cleanup

```sh 
./launch destroy
```
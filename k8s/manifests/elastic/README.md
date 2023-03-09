
This is a README for deploying ECK on k8s.

## How to deploy operator

Follow instruction on [doc](https://www.elastic.co/guide/en/cloud-on-k8s/current/k8s-deploy-eck.html).

```shell
# Set version of ECK you want to deploy
export ECK_VERSION=2.6.1

# Create required CRDs
kubectl create -f https://download.elastic.co/downloads/eck/${ECK_VERSION}/crds.yaml

# Deploy ECK operator. Operator will be deployed in namespace elastic-system.
kubectl apply -f https://download.elastic.co/downloads/eck/${ECK_VERSION}/operator.yaml

# Create ns for your elastic resources
kubectl create ns elastic
```

Now you may create any of resources.

## How to teardown

Safely delete resources.

```shell
# Remove create resources
kubectl delete -f YOUR_MANIFEST

# Remove operator
kubectl delete -f https://download.elastic.co/downloads/eck/${ECK_VERSION}/operator.yaml

# Remove CRDs
kubectl delete -f https://download.elastic.co/downloads/eck/${ECK_VERSION}/crds.yaml

# Remove ns
kubectl delete ns elastic
```
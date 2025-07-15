# eks-cluster-template
Terraform-based template for deploying a full-featured AWS EKS cluster with best practices and modular structure.

# Helm Charts Installation

After you create your infrastructure using the Terraform `render` module (step 1), the Helm `values.yaml` files are generated automatically and personalized for your environment. These files are stored in the `02-helm-charts/values` directory.

To install the required Helm charts, **navigate to the `02-helm-charts` directory** and run the following commands:

```bash
cd 02-helm-charts
```

## Install AWS Load Balancer Controller

```bash
helm upgrade --install aws-load-balancer-controller eks/aws-load-balancer-controller \
  --namespace kube-system \
  --create-namespace \
  --version 1.7.1 \
  --values ./values/aws-load-balancer-controller-values.yaml
```

## Install AWS EBS CSI Driver

```bash
helm upgrade --install aws-ebs-csi-driver aws-ebs-csi-driver/aws-ebs-csi-driver \
  --namespace kube-system \
  --version 2.30.0 \
  --values ./values/aws-ebs-csi-driver-values.yaml
```

## Install External Secrets Operator

```bash
helm upgrade --install external-secrets external-secrets/external-secrets \
  --namespace external-secrets \
  --create-namespace \
  --version 0.9.19 \
  --values ./values/external-secrets-values.yaml
```

## Install External DNS

```bash
helm upgrade --install external-dns bitnami/external-dns \
  --namespace external-dns \
  --create-namespace \
  --version 8.9.2 \
  --values values/external-dns-values.yaml
```

> Note: The necessary Helm repositories will be added automatically when these commands are run. No manual `helm repo add` is needed.

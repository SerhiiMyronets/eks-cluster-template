# eks-cluster-template
Terraform-based template for deploying a full-featured AWS EKS cluster with best practices and modular structure.

helm upgrade --install aws-load-balancer-controller eks/aws-load-balancer-controller \
--namespace kube-system \
--create-namespace \
--version 1.7.1 \
-f values/aws-load-balancer-controller-values.yaml

helm upgrade --install aws-ebs-csi-driver aws-ebs-csi-driver/aws-ebs-csi-driver \     
--namespace kube-system \
--version 2.30.0 \
--values ./values/aws-ebs-csi-driver-values.yaml

helm upgrade --install external-secrets external-secrets/external-secrets \           
--namespace external-secrets \
--create-namespace \
--version 0.9.19 \
--values ./values/external-secrets-values.yaml
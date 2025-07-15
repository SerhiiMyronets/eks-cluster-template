locals {
  manifests = {
    "aws-ebs-csi-driver-values.yaml" = templatefile("${path.module}/templates/aws-ebs-csi-driver-values.yaml.tmpl", {
      ebs_csi_irsa_arn = var.ebs_irsa_arn
    })

    "external-secrets-values.yaml" = templatefile("${path.module}/templates/external-secrets-values.yaml.tmpl", {
      external_secrets_irsa_arn = var.external_secrets_irsa_arn
    })

    "aws-load-balancer-controller-values.yaml" = templatefile("${path.module}/templates/aws-load-balancer-controller-values.yaml.tmpl", {
      alb_controller_irsa_arn = var.alb_controller_irsa_arn
      cluster_name            = var.cluster_name
      vpc_id                  = var.vpc_id
    })

    "external-dns-values.yaml" = templatefile("${path.module}/templates/external-dns-values.yaml.tmpl", {
      external_dns_irsa_arn = var.external_dns_irsa_arn
      domain_name          = var.domain_name
    })
  }
}

resource "local_file" "rendered_manifests" {
  for_each = local.manifests

  content  = each.value
  filename = "${var.output_path}/${each.key}"
}
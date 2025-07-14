locals {
  manifests = {
    "ebs-csi-controller-sa.yaml" = templatefile("aws-ebs-csi-driver-values.yaml.tmpl", {
      ebs_csi_irsa_arn = var.ebs_irsa_arn
    })

    "external-secrets-sa.yaml" = templatefile("external-secrets-values.yaml.tmpl", {
      external_secrets_irsa_arn = var.external_secrets_irsa_arn
    })

    "aws-alb-controller-sa.yaml" = templatefile("aws-load-balancer-controller-values.yaml.tmpl", {
      alb_controller_irsa_arn = var.alb_controller_irsa_arn
      cluster_name = var.cluster_name
      vpc_id = var.vpc_id
    })
  }
}

resource "local_file" "rendered_manifests" {
  for_each = local.manifests

  content  = each.value
  filename = "${var.output_path}/${each.key}"
}
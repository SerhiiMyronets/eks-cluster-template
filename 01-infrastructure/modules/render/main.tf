locals {
  manifests = {
    "ebs-csi-controller-sa.yaml" = templatefile("${path.module}/templates/ebs-csi-controller-sa.yaml.tmpl", {
      ebs_csi_irsa_arn = var.ebs_irsa_arn
    })

    "external-secrets-sa.yaml" = templatefile("${path.module}/templates/external-secrets-sa.yaml.tmpl", {
      external_secrets_irsa_arn = var.external_secrets_irsa_arn
    })
  }
}

resource "local_file" "rendered_manifests" {
  for_each = local.manifests

  content  = each.value
  filename = "${var.output_path}/${each.key}"
}
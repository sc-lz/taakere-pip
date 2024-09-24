# AWS Control Tower Controls (sometimes called Guardrails) Terraform Module
data "aws_region" "current" {}
data "aws_organizations_organization" "organization" {}

# Get OUs data resources up to five levels of OUs deep under a root (maximum nesting quota limit)
data "aws_organizations_organizational_units" "root" {
  #provider = aws.management-account-role
  parent_id = var.organisational_unit_root_id
  #parent_id = data.aws_organizations_organization.organization.roots[0].id #-> does only work in management account or delegated administrator
}


data "aws_organizations_organizational_units" "ous_depth_1" {
  #provider = aws.management-account-role
  for_each  = toset([for x in data.aws_organizations_organizational_units.root.children : x.id])
  parent_id = each.key
  depends_on = [
    data.aws_organizations_organizational_units.root
  ]
}

#commented out because it cannot be used at the moment (unless it is run in managedment account, to access children of root account)

data "aws_organizations_organizational_units" "ous_depth_2" {
  #provider = aws.management-account-role
  for_each  = toset([for y in flatten([for x in data.aws_organizations_organizational_units.ous_depth_1 : x.children]) : y.id])
  parent_id = each.key
  depends_on = [
    data.aws_organizations_organizational_units.ous_depth_1
  ]
}

data "aws_organizations_organizational_units" "ous_depth_3" {
  #provider = aws.management-account-role
  for_each  = toset([for y in flatten([for x in data.aws_organizations_organizational_units.ous_depth_2 : x.children]) : y.id])
  parent_id = each.key
  depends_on = [
    data.aws_organizations_organizational_units.ous_depth_2
  ]
}

data "aws_organizations_organizational_units" "ous_depth_4" {
  #provider = aws.management-account-role
  for_each  = toset([for y in flatten([for x in data.aws_organizations_organizational_units.ous_depth_3 : x.children]) : y.id])
  parent_id = each.key
  depends_on = [
    data.aws_organizations_organizational_units.ous_depth_3
  ]
}

locals {

  # Extract Guardrails configuration
  guardrails_list = flatten([
    for i in range(0, length(var.controls)) : [
      for pair in setproduct(element(var.controls, i).control_names, element(var.controls, i).organizational_unit_ids) :
      { "arn:aws:controltower:${data.aws_region.current.name}::control/${pair[0]}" = pair[1] }
    ]
  ])

  #commented out because it cannot be used at the moment (unless it is run in managedment account, to access children of root account)
  ous_depth_1 = [for x in data.aws_organizations_organizational_units.root.children : x]
  ous_depth_2 = flatten([for x in data.aws_organizations_organizational_units.ous_depth_1 : x.children if length(x.children) != 0])
  ous_depth_3 = flatten([for x in data.aws_organizations_organizational_units.ous_depth_2 : x.children if length(x.children) != 0])
  ous_depth_4 = flatten([for x in data.aws_organizations_organizational_units.ous_depth_3 : x.children if length(x.children) != 0])
  ous_depth_5 = flatten([for x in data.aws_organizations_organizational_units.ous_depth_4 : x.children if length(x.children) != 0])

  # Compute map from OU id to OU arn for the whole organization
  ous_id_to_arn_map = { for ou in concat(local.ous_depth_1, local.ous_depth_2, local.ous_depth_3, local.ous_depth_4, local.ous_depth_5) :
    ou.id => ou.arn
  }

}

resource "aws_controltower_control" "guardrails" {
  #provider = aws.management-account-role
  for_each = { for control in local.guardrails_list : join(":", [keys(control)[0], values(control)[0]]) => [keys(control)[0], values(control)[0]] }

  control_identifier = each.value[0]

  target_identifier = local.ous_id_to_arn_map[each.value[1]]

}

data "aws_controltower_controls" "this" {

  target_identifier = [
    for x in data.aws_organizations_organizational_units.root.children :
    x.arn if x.name == "Security"
  ][0]

}


# terraform import aws_controltower_control.guardrails arn:aws:organizations::268702346055:ou/o-9ao1kn1kyw/ou-nmu5-5l01e2ro,arn:aws:controlcatalog:::control/b7a0rdepu2tfjgo0ddxo9waw0

# List buckets: aws s3api list-buckets --profile MGM  

# List controls: aws controltower list-enabled-controls --target-identifier arn:aws:organizations::268702346055:ou/o-9ao1kn1kyw/ou-nmu5-5l01e2ro --profile MGM

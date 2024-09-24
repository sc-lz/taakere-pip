/*
resource "aws_controltower_control" "guardrails" {
  #provider = aws.management-account-role
  for_each = { for control in local.guardrails_list : join(":", [keys(control)[0], values(control)[0]]) => [keys(control)[0], values(control)[0]] }

  control_identifier = each.value[0]

  target_identifier = local.ous_id_to_arn_map[each.value[1]]

}
*/

resource "aws_controltower_control" "guardrails" {
  control_identifier = "arn:aws:controlcatalog:::control/1iskvg0qcxofs1t78ittjbnr5"
  target_identifier = "arn:aws:organizations::268702346055:ou/o-9ao1kn1kyw/ou-nmu5-5l01e2ro"
}


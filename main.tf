#invoke guardrail module
module "control_tower_guardrails" {
  count                       = var.enable_guardrails_module ? 1 : 0
  source                      = "./modules/guardrails"
  organisational_unit_root_id = var.organisational_unit_root_id
  controls                    = var.controls


}

import {
  to = aws_controltower_control.guardrails
  id = "arn:aws:organizations::268702346055:ou/o-9ao1kn1kyw/ou-nmu5-5l01e2ro,arn:aws:controlcatalog:::control/b7a0rdepu2tfjgo0ddxo9waw0"
}


#invoke backup module


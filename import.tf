/*
//This code works to import one guardrail at a time

resource "aws_controltower_control" "guardrails_v6" {
    control_identifier = "arn:aws:controltower:eu-central-1::control/URQEHVTSKLLB" #CT.CLOUDWATCH.PR.2
    target_identifier = "arn:aws:organizations::268702346055:ou/o-9ao1kn1kyw/ou-nmu5-5l01e2ro"
    }


import {  
  to = aws_controltower_control.guardrails_v6 
  id = "arn:aws:organizations::268702346055:ou/o-9ao1kn1kyw/ou-nmu5-5l01e2ro,arn:aws:controltower:eu-central-1::control/URQEHVTSKLLB"
  }
 
 */

 //Code to import multiple guardrails at once

variable "control_names" {
  type = list(string)
  default = [
    "URQEHVTSKLLB",  # CT.CLOUDWATCH.PR.2
    "AWS-GR_CLOUDTRAIL_CHANGE_PROHIBITED", 
    "GR_CLOUDTRAIL_CLOUDWATCH_LOGS_ENABLED"
    # Add more control names here
  ]
}

variable "ou_arn" {
  type    = string
  default = "arn:aws:organizations::268702346055:ou/o-9ao1kn1kyw/ou-nmu5-5l01e2ro"
}

variable "control_base_arn" {
  type    = string
  default = "arn:aws:controltower:eu-central-1::control"
}

resource "aws_controltower_control" "import_guardrails" {
  for_each = { for name in var.control_names : name => name }

  control_identifier = "${var.control_base_arn}/${each.value}"
  target_identifier  = var.ou_arn
}

# Dynamic import blocks
resource "null_resource" "import_guardrails" {
  for_each = { for name in var.control_names : name => name }

  provisioner "local-exec" {
    command = <<EOT
cat <<EOF >> import.tf
import {
  to = aws_controltower_control.import_guardrails["${each.key}"]
  id = "${var.ou_arn},${var.control_base_arn}/${each.key}"
}
EOF
EOT
  }
}
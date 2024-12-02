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
# Define the list of Guardrails with control and target identifiers

variable "guardrails_import_list" {
  type = list(object({
    control_identifier = string
    target_identifier  = string
  }))
  default = [
    {
      control_identifier = "arn:aws:controltower:eu-central-1::control/URQEHVTSKLLB"
      target_identifier  = "arn:aws:organizations::268702346055:ou/o-9ao1kn1kyw/ou-nmu5-5l01e2ro"
    },
    {
      control_identifier = "arn:aws:controltower:eu-central-1::control/GR_CLOUDTRAIL_CLOUDWATCH_LOGS_ENABLED"
      target_identifier  = "arn:aws:organizations::268702346055:ou/o-9ao1kn1kyw/ou-nmu5-5l01e3ro"
    },
    {
      control_identifier = "arn:aws:controltower:eu-central-1::control/OBZIVWNWNIFK"
      target_identifier  = "arn:aws:organizations::268702346055:ou/o-9ao1kn1kyw/ou-nmu5-5l01e3ro"
    }
  ]
}

resource "aws_controltower_control" "import_guardrail" {
  for_each = { for idx, guardrail in var.guardrails_import_list : idx => guardrail }

  control_identifier = each.value.control_identifier
  target_identifier  = each.value.target_identifier
}

import {  
  for_each = { for idx, guardrail in var.guardrails_import_list : idx => guardrail }

  to = aws_controltower_control.import_guardrail
  id = join(",", [each.value.target_identifier, each.value.control_identifier])
  }

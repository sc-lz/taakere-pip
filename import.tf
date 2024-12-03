
//This code works to import one guardrail at a time

/*resource "aws_controltower_control" "guardrails_import_1" {
    control_identifier = "arn:aws:controltower:eu-central-1::control/URQEHVTSKLLB" #CT.CLOUDWATCH.PR.2
    target_identifier = "arn:aws:organizations::268702346055:ou/o-9ao1kn1kyw/ou-nmu5-5l01e2ro"
    }

    import {  
  to = aws_controltower_control.guardrails_import_1 
  id = "arn:aws:organizations::268702346055:ou/o-9ao1kn1kyw/ou-nmu5-5l01e2ro,arn:aws:controltower:eu-central-1::control/URQEHVTSKLLB"
  }
*/
resource "aws_controltower_control" "guardrails_import_2" {
    control_identifier = "arn:aws:controltower:eu-central-1::control/AWS-GR_CLOUDTRAIL_CHANGE_PROHIBITED"
    target_identifier = "arn:aws:organizations::268702346055:ou/o-9ao1kn1kyw/ou-nmu5-5l01e2ro"
    }    

 import {  
  to = aws_controltower_control.guardrails_import_2 
  id = "arn:aws:organizations::268702346055:ou/o-9ao1kn1kyw/ou-nmu5-5l01e2ro,arn:aws:controltower:eu-central-1::control/AWS-GR_CLOUDTRAIL_CHANGE_PROHIBITED"
  }

 //Code to import multiple guardrails at once
# Define the list of Guardrails with control and target identifiers

/*
variable "guardrails_import_list" {
  type = list(string)
  default = [
    "arn:aws:controltower:eu-central-1::control/k4izcjxhukijhajp6ks5mjxk", 
    "arn:aws:controltower:eu-central-1::control/AWS-GR_CLOUDTRAIL_CHANGE_PROHIBITED", 
    "arn:aws:controltower:eu-central-1::control/AWS-GR_CLOUDTRAIL_CLOUDWATCH_LOGS_ENABLED"
  ]
}

resource "aws_controltower_control" "import_guardrails_dynamic" {
  for_each = { for idx, guardrail in var.guardrails_import_list : 
                "import_guardrails_${idx}" => guardrail }

  control_identifier = each.value
  target_identifier  = "arn:aws:organizations::268702346055:ou/o-9ao1kn1kyw/ou-nmu5-5l01e2ro"
}

resource "aws_controltower_control" "import_guardrails_with_import" {
  for_each = { for idx, guardrail in var.guardrails_import_list : 
                "import_guardrails_${idx}" => guardrail }

  control_identifier = each.value
  target_identifier  = "arn:aws:organizations::268702346055:ou/o-9ao1kn1kyw/ou-nmu5-5l01e2ro"

  import {
    id  = each.value
    to  = aws_controltower_control.import_guardrails_dynamic[each.key]
  }
}
*/
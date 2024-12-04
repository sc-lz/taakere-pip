
//This code works to import one guardrail at a time
/*
resource "aws_controltower_control" "guardrails_import_1" {
    control_identifier = "arn:aws:controltower:eu-central-1::control/OBZIVWNWNIFK" 
    target_identifier = "arn:aws:organizations::268702346055:ou/o-9ao1kn1kyw/ou-nmu5-5l01e2ro"
    }

import {  
  to = aws_controltower_control.guardrails_import_1 
  id = "arn:aws:organizations::268702346055:ou/o-9ao1kn1kyw/ou-nmu5-5l01e2ro,arn:aws:controltower:eu-central-1::control/OBZIVWNWNIFK"
  }
  

resource "aws_controltower_control" "guardrails_import_2" {
    control_identifier = "arn:aws:controltower:eu-central-1::control/AWS-GR_CLOUDTRAIL_CHANGE_PROHIBITED" //Mandatory Guardrail
    target_identifier = "arn:aws:organizations::268702346055:ou/o-9ao1kn1kyw/ou-nmu5-5l01e2ro"
    }    

 import {  
  to = aws_controltower_control.guardrails_import_2 
  id = "arn:aws:organizations::268702346055:ou/o-9ao1kn1kyw/ou-nmu5-5l01e2ro,arn:aws:controltower:eu-central-1::control/AWS-GR_CLOUDTRAIL_CHANGE_PROHIBITED"
  }

resource "aws_controltower_control" "guardrails_import_3" {
    control_identifier = "arn:aws:controltower:eu-central-1::control/AWS-GR_CLOUDTRAIL_ENABLED" //Mandatory Guardrail
    target_identifier = "arn:aws:organizations::268702346055:ou/o-9ao1kn1kyw/ou-nmu5-5l01e2ro"
    }    

 import {  
  to = aws_controltower_control.guardrails_import_3 
  id = "arn:aws:organizations::268702346055:ou/o-9ao1kn1kyw/ou-nmu5-5l01e2ro,arn:aws:controltower:eu-central-1::control/AWS-GR_CLOUDTRAIL_ENABLED"
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

locals {
  guardrails = [
    {
      name               = "guardrails_import_1"
      control_identifier = "arn:aws:controltower:eu-central-1::control/OBZIVWNWNIFK"
    },
    {
      name               = "guardrails_import_2"
      control_identifier = "arn:aws:controltower:eu-central-1::control/AWS-GR_CLOUDTRAIL_CHANGE_PROHIBITED"
    },
    {
      name               = "guardrails_import_3"
      control_identifier = "arn:aws:controltower:eu-central-1::control/AWS-GR_CLOUDTRAIL_ENABLED"
    }
    # Add more guardrails here
  ]
}

variable "ou_arn" {
  type    = string
  default = "arn:aws:organizations::268702346055:ou/o-9ao1kn1kyw/ou-nmu5-5l01e2ro"
}

resource "aws_controltower_control" "import_guardrails" {
  for_each = { for idx, guardrail in local.guardrails : guardrail.name => guardrail }

  control_identifier = each.value.control_identifier
  target_identifier  = var.ou_arn
}

# Dynamic import blocks
resource "null_resource" "import_guardrails" {
  for_each = { for idx, guardrail in local.guardrails : guardrail.name => guardrail }

  provisioner "local-exec" {
    command = <<EOT
cat <<EOF >> import.tf
import {
  to = aws_controltower_control.import_guardrails["${each.key}"]
  id = "${var.ou_arn},${each.value.control_identifier}"
}
EOF
EOT
  }
}
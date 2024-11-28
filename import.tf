/*
resource "aws_controltower_control" "guardrails_v6" {
    control_identifier = "arn:aws:controltower:eu-central-1::control/URQEHVTSKLLB" #CT.CLOUDWATCH.PR.2
    target_identifier = "arn:aws:organizations::268702346055:ou/o-9ao1kn1kyw/ou-nmu5-5l01e2ro"
    }
"arn:aws:organizations::268702346055:ou/o-9ao1kn1kyw/ou-nmu5-5l01e2ro,arn:aws:controltower:eu-central-1::control/AWS-GR_DISALLOW_VPN_CONNECTIONS"

import {  
  to = aws_controltower_control.guardrails_v6 
  id = "arn:aws:organizations::268702346055:ou/o-9ao1kn1kyw/ou-nmu5-5l01e2ro,arn:aws:controltower:eu-central-1::control/URQEHVTSKLLB"
  }
  
 */ 
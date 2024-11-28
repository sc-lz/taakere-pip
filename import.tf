/*
resource "aws_controltower_control" "guardrails_v6" {
    control_identifier = "arn:aws:controlcatalog:::control/de5sygz3v7a2rhq921s59xna6" #CT.CLOUDWATCH.PR.2
    target_identifier = "arn:aws:organizations::268702346055:ou/o-9ao1kn1kyw/ou-nmu5-5l01e2ro"
    }


import {  
  to = aws_controltower_control.guardrails_v6 
  id = "arn:aws:organizations::268702346055:ou/o-9ao1kn1kyw/ou-nmu5-5l01e2ro,arn:aws:controlcatalog:::control/de5sygz3v7a2rhq921s59xna6"
  }
  
 */ 
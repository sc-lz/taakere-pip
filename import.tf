
//Import guardrails as bloc
locals {
  //OU ARN
  target_identifier = "arn:aws:organizations::268702346055:ou/o-9ao1kn1kyw/ou-nmu5-5l01e2ro"

  //ARN of Guardrail -> https://docs.aws.amazon.com/controltower/latest/controlreference/control-metadata-tables.html
  guardrails = {
    guardrail_1 = {
      control_identifier = "arn:aws:controltower:eu-central-1::control/AWS-GR_CONFIG_AGGREGATION_AUTHORIZATION_POLICY"
    }
    guardrail_2 = {
      control_identifier = "arn:aws:controltower:eu-central-1::control/AWS-GR_CLOUDTRAIL_CHANGE_PROHIBITED"
    }
    guardrail_3 = {
      control_identifier = "arn:aws:controltower:eu-central-1::control/AWS-GR_CLOUDTRAIL_ENABLED"
    }
    guardrail_4 = {
      control_identifier = "arn:aws:controltower:eu-central-1::control/AWS-GR_IAM_USER_MFA_ENABLED"
    }
    guardrail_5 = {
      control_identifier = "arn:aws:controltower:eu-central-1::control/AWS-GR_LOG_GROUP_POLICY"
    }
    guardrail_6 = {
      control_identifier = "arn:aws:controltower:eu-central-1::control/XHEVQAZTSEAZ" //CT.APIGATEWAY.PR.1
    }
    guardrail_7 = {
      control_identifier = "arn:aws:controltower:eu-central-1::control/PEIQUNSHAALC" //CT.APIGATEWAY.PR.2
    }
    
    guardrail_8 = {
      control_identifier = "arn:aws:controltower:eu-central-1::control/TAYPGUHJACMN" //CT.APIGATEWAY.PR.3
    }
    
  }

}



resource "aws_controltower_control" "guardrails" {
  for_each           = local.guardrails
  control_identifier = each.value.control_identifier
  target_identifier  = local.target_identifier
}

import {
  for_each = local.guardrails
  id       = "${local.target_identifier},${each.value.control_identifier}"
  to       = aws_controltower_control.guardrails[each.key]
}





/*
//This code works to import one guardrail at a time

resource "aws_controltower_control" "guardrails_import_1" {
    control_identifier = "arn:aws:controltower:eu-central-1::control/AWS-GR_CONFIG_AGGREGATION_AUTHORIZATION_POLICY" 
    target_identifier = "arn:aws:organizations::268702346055:ou/o-9ao1kn1kyw/ou-nmu5-5l01e2ro"
    }

import {  
  to = aws_controltower_control.guardrails_import_1
  id = "arn:aws:organizations::268702346055:ou/o-9ao1kn1kyw/ou-nmu5-5l01e2ro,arn:aws:controltower:eu-central-1::control/AWS-GR_CONFIG_AGGREGATION_AUTHORIZATION_POLICY"
  }

  
*/
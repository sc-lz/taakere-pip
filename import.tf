
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
      control_identifier = "arn:aws:controlcatalog:::control/1nbiz41n920vxbjbyfh05h0v6" //CT.APIGATEWAY.PR.3
    }

    guardrail_9 = {
      control_identifier = "arn:aws:controltower:eu-central-1::control/AWS-GR_LAMBDA_CHANGE_PROHIBITED" //AWS-GR_LAMBDA_CHANGE_PROHIBITED
    }

    guardrail_10 = {
      control_identifier = "arn:aws:controlcatalog:::control/2j9gjxqfo040xtx8kd1jf4ni6" //AWS-GR_EBS_OPTIMIZED_INSTANCE
    }

    guardrail_11 = {
      control_identifier = "arn:aws:controlcatalog:::control/8ui9y3oace2513xarz8aqojl7" //AWS-GR_RESTRICT_ROOT_USER_ACCESS_KEYS
    }

    guardrail_12 = {
      control_identifier = "arn:aws:controlcatalog:::control/3qpnxfs5vtzd2v2ql2f2mu7tq" //CT.LAMBDA.PV.1
    }

    guardrail_13 = {
      control_identifier = "arn:aws:controlcatalog:::control/1csaqxiy3h463r51ehmcygrs2" //CT.DOCUMENTDB.PR.1
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

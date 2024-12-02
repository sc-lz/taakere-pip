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
  type = list(string)
  default = [
    "arn:aws:controltower:eu-central-1::control/k4izcjxhukijhajp6ks5mjxk", 
    "arn:aws:controltower:eu-central-1::control/AWS-GR_CLOUDTRAIL_CHANGE_PROHIBITED", 
    "arn:aws:controltower:eu-central-1::control/AWS-GR_CLOUDTRAIL_CLOUDWATCH_LOGS_ENABLED", 
    "arn:aws:controltower:eu-central-1::control/AWS-GR_CLOUDTRAIL_ENABLED", 
    "arn:aws:controltower:eu-central-1::control/AWS-GR_CLOUDTRAIL_VALIDATION_ENABLED", 
    "arn:aws:controltower:eu-central-1::control/AWS-GR_CLOUDWATCH_EVENTS_CHANGE_PROHIBITED", 
    "arn:aws:controltower:eu-central-1::control/AWS-GR_CONFIG_AGGREGATION_AUTHORIZATION_POLICY", 
    "arn:aws:controltower:eu-central-1::control/AWS-GR_CONFIG_AGGREGATION_CHANGE_PROHIBITED"
  ]
}

resource "aws_controltower_control" "import_guardrails" {
  for_each = toset(var.guardrails_import_list)

  control_identifier = each.value
  target_identifier  = "arn:aws:organizations::268702346055:ou/o-9ao1kn1kyw/ou-nmu5-5l01e2ro"
}

# Import each resource one by one, manually specified
import {
  id = "arn:aws:controltower:eu-central-1::control/k4izcjxhukijhajp6ks5mjxk"
  to = aws_controltower_control.import_guardrails["k4izcjxhukijhajp6ks5mjxk"]
}

import {
  id = "arn:aws:controltower:eu-central-1::control/AWS-GR_CLOUDTRAIL_CHANGE_PROHIBITED"
  to = aws_controltower_control.import_guardrails["AWS-GR_CLOUDTRAIL_CHANGE_PROHIBITED"]
}

import {
  id = "arn:aws:controltower:eu-central-1::control/AWS-GR_CLOUDTRAIL_CLOUDWATCH_LOGS_ENABLED"
  to = aws_controltower_control.import_guardrails["AWS-GR_CLOUDTRAIL_CLOUDWATCH_LOGS_ENABLED"]
}

import {
  id = "arn:aws:controltower:eu-central-1::control/AWS-GR_CLOUDTRAIL_ENABLED"
  to = aws_controltower_control.import_guardrails["AWS-GR_CLOUDTRAIL_ENABLED"]
}

import {
  id = "arn:aws:controltower:eu-central-1::control/AWS-GR_CLOUDTRAIL_VALIDATION_ENABLED"
  to = aws_controltower_control.import_guardrails["AWS-GR_CLOUDTRAIL_VALIDATION_ENABLED"]
}

import {
  id = "arn:aws:controltower:eu-central-1::control/AWS-GR_CLOUDWATCH_EVENTS_CHANGE_PROHIBITED"
  to = aws_controltower_control.import_guardrails["AWS-GR_CLOUDWATCH_EVENTS_CHANGE_PROHIBITED"]
}

import {
  id = "arn:aws:controltower:eu-central-1::control/AWS-GR_CONFIG_AGGREGATION_AUTHORIZATION_POLICY"
  to = aws_controltower_control.import_guardrails["AWS-GR_CONFIG_AGGREGATION_AUTHORIZATION_POLICY"]
}

import {
  id = "arn:aws:controltower:eu-central-1::control/AWS-GR_CONFIG_AGGREGATION_CHANGE_PROHIBITED"
  to = aws_controltower_control.import_guardrails["AWS-GR_CONFIG_AGGREGATION_CHANGE_PROHIBITED"]
}

# Values for Control Tower Controls module
enable_guardrails_module    = true
organisational_unit_root_id = "r-nmu5"
controls = [
  {
    control_names = [
      "PEIQUNSHAALC", // | CT.APIGATEWAY.PR.2 | Config rule | Elective
      "AWS-GR_DISALLOW_VPN_CONNECTIONS", // | AWS-GR_DISALLOW_VPN_CONNECTIONS AWS-GR_DISALLOW_VPN_CONNECTIONS | Config rule | Elective | arn:aws:controlcatalog:::control/dry4lj30s7u6k42r73hitwpjq
     // "URQEHVTSKLLB", //CT.CLOUDWATCH.PR.2
     // "AWS-GR_CLOUDTRAIL_CHANGE_PROHIBITED",
     // "LQQDNIWFNOQQ" // | CT.AUTOSCALING.PR.1 | Proactive 
    ],
    organizational_unit_ids = ["ou-nmu5-5l01e2ro"],
  }
]


# Values for Backup policy module.

/*
//Import

// Import variables for ARNs construction
control_names = [
  "URQEHVTSKLLB",  # CT.CLOUDWATCH.PR.2
  "AWS-GR_CLOUDTRAIL_CHANGE_PROHIBITED",  # Another control
  "GR_CLOUDTRAIL_CLOUDWATCH_LOGS_ENABLED"
  # Add more control names here with comma separation
]

ou_arn = "arn:aws:organizations::268702346055:ou/o-9ao1kn1kyw/ou-nmu5-5l01e2ro"
control_base_arn = "arn:aws:controltower:eu-central-1::control"

*/
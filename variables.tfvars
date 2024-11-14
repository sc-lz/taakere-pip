# Values for Control Tower Controls module
enable_guardrails_module    = true
organisational_unit_root_id = "r-nmu5"
controls = [
  {
    control_names = [
      "PEIQUNSHAALC", // | CT.APIGATEWAY.PR.2 | Config rule | Elective
      "AWS-GR_DISALLOW_VPN_CONNECTIONS", // | AWS-GR_DISALLOW_VPN_CONNECTIONS | Config rule | Elective | arn:aws:controlcatalog:::control/dry4lj30s7u6k42r73hitwpjq
     // "AWS-GR_CLOUDTRAIL_CHANGE_PROHIBITED",
      "LQQDNIWFNOQQ" // | CT.AUTOSCALING.PR.1 | Proactive 
    ],
    organizational_unit_ids = ["ou-nmu5-5l01e2ro"],
  }
]


# Values for Backup policy module.

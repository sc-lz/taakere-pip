# Values for Control Tower Controls module
enable_guardrails_module    = true
organisational_unit_root_id = "r-nmu5"
controls = [
  {
    control_names = [
      "PEIQUNSHAALC", // | CT.APIGATEWAY.PR.2 | Config rule | Elective
     
      //test for Guardrails filter
      
      //activated AWS-GR_S3_VERSIONING_ENABLED manually previously and now again in terraform for testing
      //"AWS-GR_S3_VERSIONING_ENABLED", // | Testing after enabling in AWS manually | Config rule | Detective
      //"AWS-GR_MFA_ENABLED_FOR_IAM_CONSOLE_ACCESS"  // Test | Detective
    ],
    organizational_unit_ids = ["ou-nmu5-5l01e2ro"],
  }
]


# Values for backup policy module.

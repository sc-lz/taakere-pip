## create provider in management account -> TODO
provider "aws" {
  region = "eu-central-1"
  assume_role {
    role_arn = "arn:aws:iam::268702346055:role/RoleForAutomationPipeline" #TOBE changes
  }
  alias  = "management-account-backup-role"
}


/* Required permissions

    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Sid": "RegisterDelegatedAdmin",
                "Action": [
                    "organizations:RegisterDelegatedAdministrator"
                ],
                "Effect": "Allow",
                "Resource": "*"
            },
            {
                "Sid": "UpdateAwsBackupGlobalSetting",
                "Action": [
                    "backup:UpdateGlobalSettings"
                ],
                "Effect": "Allow",
                "Resource": "*"
            },
            {
                "Sid": "ManageAwsOrganizationResourcePolicy",
                "Action": [
                    "organizations:PutResourcePolicy",
                    "organizations:DeleteResourcePolicy"
                ],
                "Effect": "Allow",
                "Resource": "*"
            },
            {
                "Sid": "DescribeAwsOrganizationResources",
                "Action": [
                    "organizations:Describe*",
                    "organizations:List*"
                ],
                "Effect": "Allow",
                "Resource": "*"
            }
        ]
}

*/
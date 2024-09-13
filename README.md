# Deploy and manage AWS Control Tower controls by using Terraform

- [Deploy and manage AWS Control Tower controls by using Terraform](#deploy-and-manage-aws-control-tower-controls-by-using-terraform)
  - [Goal](#goal)
  - [Prerequisites and limitations](#prerequisites-and-limitations)
  - [Usage](#usage)
    - [Inputs](#inputs)
    - [Outputs](#outputs)
    - [Controls Configuration File](#controls-configuration-file)
  - [Deployment](#deployment)


## Goal

This README describes how to use infrastructure as code (IaC) to manage some AWS Landing Zone aspects, in particular AWS Control Tower controls (also known as a guardrails), and Backup Policies. 

## Prerequisites and limitations

- Active AWS accounts managed as an organization in AWS Organizations and an AWS Control Tower landing zone. For instructions, see [Create an account structure](https://www.wellarchitectedlabs.com/cost/100_labs/100_1_aws_account_setup/2_account_structure/) (AWS Well-Architected Labs).

- Apply the service control policy (SCP)-based control with the identifier CLOUDFORMATION.PR.1. This SCP must be activated to deploy proactive controls. For instructions, see [Disallow management of resource types, modules, and hooks within the AWS CloudFormation registry.](https://docs.aws.amazon.com/controltower/latest/userguide/elective-controls.html#disallow-cfn-extensions)

## Usage

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_controls"></a> [controls](#input\_controls) | Configuration of AWS Control Tower Guardrails for the whole organization | <pre>list(object({<br>    control_names           = list(string)<br>    organizational_unit_ids = list(string)<br>  }))</pre> | n/a | yes |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_ous_id_to_arn_map"></a> [ous\_id\_to\_arn\_map](#output\_ous\_id\_to\_arn\_map) | Map from OU id to OU arn for the whole organization |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->


### Controls Configuration File

The following is an example of an updated `variables.tfvars` file.
```
controls = [
    {
        control_names = [
            "AWS-GR_ENCRYPTED_VOLUMES",
            ...
        ],
        organizational_unit_ids = ["ou-1111-11111111", "ou-2222-22222222"...],
    },
    {
        control_names = [
            "AWS-GR_SUBNET_AUTO_ASSIGN_PUBLIC_IP_DISABLED",
            ...
        ],
        organizational_unit_ids = ["ou-1111-11111111"...],
    },
]
```

1. In the `controls` section, in the `control_names` parameter, enter the control API identifier. Each control has a unique API identifier for each Region in which AWS Control Tower is available. To find the control identifier, do the following:

    1. In [Tables of control metadata](https://docs.aws.amazon.com/controltower/latest/userguide/control-metadata-tables.html), locate the control you want to enable.

    2. In the Control API identifiers, by Region column, locate the API identifier for the Region in which you are making the API call, such as `arn:aws:controltower:us-east-1::control/AWS-GR_AUDIT_BUCKET_ENCRYPTION_ENABLED`.

    3. Extract the control identifier from the Regional identifier, such as `GR_AUDIT_BUCKET_ENCRYPTION_ENABLED`.

2. In the `controls` section, in the `organizational_unit_ids` parameter, enter the ID of the organizational unit where you want to enable the control, such as `ou-1111-11111111`. Enter the ID in double quotation marks, and separate multiple IDs with commas. For more information about how to retrieve OU IDs, see Viewing the [details of an OU](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_org_details.html#orgs_view_ou).

3. Save and close the variables.tfvars file. For an example of an updated variables.tfvars file, see the [Additional information](https://docs.aws.amazon.com/prescriptive-guidance/latest/patterns/deploy-and-manage-aws-control-tower-controls-by-using-terraform.html#deploy-and-manage-aws-control-tower-controls-by-using-terraform-additional) section of this pattern.


## Deployment

1. Commit your changes to the variables.tfvars file
2. Push to the CodeCommit repository
3. Monitor the terraform deployment on the CodePipeline


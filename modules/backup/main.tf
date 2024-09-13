 module "backup-delegated-ORG-admin" {
   source    = "./backup-organization-policy"

   providers = { aws = aws.management-account-backup-role }

   delegate_account_id = var.delegate_account_id
 }

 # Terraform module to manage the Central Backup policy in the delegated backup account
module "central-backup-policy" {
   source    = "./central-backup-policy"

   providers = { aws = aws.delegate_backup_account }

   #for_each = {
   # for idx, region_set in local.target_regions :
   # idx => region_set
   #}

   name                       = "organization-backup-policy"
   backup_cron_schedule       = "cron(0 2 * * ? *)"  # Triggers by 2 AM daily (UTC)
   backup_selection_role_name = "backup-selection-role"
   vault_name                 = "user-backup-vault"
   backup_selection_tags = {
     Backup = ["true"]
   }

   target_resource_region = each.value.target_resource_region
   secondary_vault_region = each.value.secondary_vault_region

   depends_on = [
     module.backup-delegated-ORG-admin # If using a delegated backup setup
   ]
 }
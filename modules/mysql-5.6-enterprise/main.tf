
provider "alicloud" {
  profile                 = var.profile != "" ? var.profile : null
  shared_credentials_file = var.shared_credentials_file != "" ? var.shared_credentials_file : null
  region                  = var.region != "" ? var.region : null
  skip_region_validation  = var.skip_region_validation
  configuration_source    = "terraform-alicloud-modules/rds-mysql"
}
locals {
  engine         = "MySQL"
  engine_version = "5.6"
}
data "alicloud_db_instance_classes" "default" {
  engine         = local.engine
  engine_version = local.engine_version
  category       = "Enterprise"
  storage_type   = var.instance_storage_type
}
module "mysql" {
  source = "../../"
  region = var.region
  #################
  # Rds Instance
  #################
  create_instance      = var.create_instance
  engine_version       = local.engine_version
  instance_type        = var.instance_type != "" ? var.instance_type : data.alicloud_db_instance_classes.default.instance_classes.0.instance_class
  instance_storage     = var.instance_storage != "" ? var.instance_storage : lookup(data.alicloud_db_instance_classes.default.instance_classes.0.storage_range, "min")
  instance_charge_type = var.instance_charge_type
  instance_name        = var.instance_name
  security_group_ids   = var.security_group_ids
  vswitch_id           = var.vswitch_id
  security_ips         = var.security_ips
  tags                 = var.tags
  #################
  # Rds Backup policy
  #################
  preferred_backup_period     = var.preferred_backup_period
  preferred_backup_time       = var.preferred_backup_time
  backup_retention_period     = var.backup_retention_period
  log_backup_retention_period = var.log_backup_retention_period
  enable_backup_log           = var.enable_backup_log
  #################
  # Rds Connection
  #################
  port                       = var.port
  connection_prefix          = var.connection_prefix
  allocate_public_connection = var.allocate_public_connection
  #################
  # Rds Database account
  #################
  account_type      = var.account_type
  account_privilege = var.account_privilege
  create_account    = var.create_account
  account_name      = var.account_name
  account_password  = var.account_password
  #################
  # Rds Database
  #################
  create_database = var.create_database
  databases       = var.databases
  #############
  # cms_alarm
  #############
  alarm_rule_name            = var.alarm_rule_name
  alarm_rule_statistics      = var.alarm_rule_statistics
  alarm_rule_period          = var.alarm_rule_period
  alarm_rule_operator        = var.alarm_rule_operator
  alarm_rule_threshold       = var.alarm_rule_threshold
  alarm_rule_triggered_count = var.alarm_rule_triggered_count
  alarm_rule_contact_groups  = var.alarm_rule_contact_groups
  enable_alarm_rule          = var.enable_alarm_rule
}
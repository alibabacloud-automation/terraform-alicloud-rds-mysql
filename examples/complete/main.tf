data "alicloud_db_zones" "default" {
}

data "alicloud_cms_alarm_contact_groups" "default" {
}

data "alicloud_db_instance_classes" "default" {
  engine         = "MySQL"
  engine_version = "5.6"
}

module "vpc" {
  source             = "alibaba/vpc/alicloud"
  create             = true
  vpc_cidr           = "172.16.0.0/16"
  vswitch_cidrs      = ["172.16.0.0/21"]
  availability_zones = [data.alicloud_db_zones.default.zones.0.id]
}

module "security_group" {
  source = "alibaba/security-group/alicloud"
  vpc_id = module.vpc.this_vpc_id
}

module "mysql" {
  source = "../.."

  #databases
  create_instance = true
  create_database = true
  create_account  = true

  databases = [
    {
      name          = "tf_testacc_db"
      character_set = "utf8"
      description   = var.description
    }
  ]
  account_name      = "account_name"
  account_password  = var.account_password
  account_type      = "Normal"
  account_privilege = "ReadOnly"

  #alicloud_db_instance
  engine_version       = "5.6"
  instance_name        = var.instance_name
  instance_type        = data.alicloud_db_instance_classes.default.instance_classes.0.instance_class
  instance_storage     = var.instance_storage
  instance_charge_type = var.instance_charge_type
  period               = var.period
  security_ips         = var.security_ips
  vswitch_id           = module.vpc.this_vswitch_ids[0]
  security_group_ids   = [module.security_group.this_security_group_id]
  tags                 = var.tags

  #alicloud_db_backup_policy
  create_backup_policy = true

  backup_retention_period     = var.backup_retention_period
  log_backup_retention_period = var.log_backup_retention_period
  preferred_backup_time       = var.preferred_backup_time
  preferred_backup_period     = var.preferred_backup_period
  enable_backup_log           = var.enable_backup_log

  #alicloud_db_connection
  allocate_public_connection = true

  connection_prefix = "tf-testacc"
  port              = 3306

  #alicloud_cms_alarm
  enable_alarm_rule             = var.enable_alarm_rule
  alarm_rule_name               = var.alarm_rule_name
  alarm_rule_statistics         = var.alarm_rule_statistics
  alarm_rule_operator           = var.alarm_rule_operator
  alarm_rule_threshold          = var.alarm_rule_threshold
  alarm_rule_triggered_count    = var.alarm_rule_triggered_count
  alarm_rule_period             = var.alarm_rule_period
  alarm_rule_contact_groups     = data.alicloud_cms_alarm_contact_groups.default.names
  alarm_rule_silence_time       = var.alarm_rule_silence_time
  alarm_rule_effective_interval = var.alarm_rule_effective_interval

}
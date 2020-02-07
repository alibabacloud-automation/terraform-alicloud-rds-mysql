variable "region" {
  default = "cn-beijing"
}
provider "alicloud" {
  region = var.region
}
data "alicloud_vpcs" "default" {
  is_default = true
}
module "security_group" {
  source = "alibaba/security-group/alicloud"
  region = var.region
  vpc_id = data.alicloud_vpcs.default.ids.0
}

module "mysql" {
  source = "../../modules/mysql-5.7-basic"
  region = var.region

  #################
  # Rds Instance
  #################
  vswitch_id         = data.alicloud_vpcs.default.vpcs.0.vswitch_ids.0
  instance_name      = "MysqlInstance"
  security_group_ids = [module.security_group.this_security_group_id]
  security_ips = [
    "11.193.54.0/24",
    "101.37.74.0/24",
    "10.137.42.0/24",
  "121.43.18.0/24"]
  #################
  # Rds Backup policy
  #################
  preferred_backup_period     = ["Monday", "Wednesday"]
  preferred_backup_time       = "00:00Z-01:00Z"
  backup_retention_period     = 7
  log_backup_retention_period = 7
  enable_backup_log           = true
  instance_type               = "rds.mysql.s2.large"
  ##############
  # connection
  ##############
  allocate_public_connection = false
  connection_prefix          = "mysqlconnection"
  ###########
  #databases#
  ###########
  account_privilege = "ReadWrite"
  databases = [
    {
      name          = "dbuserv1"
      character_set = "utf8"
      description   = "db1"
    },
    {
      name          = "dbuserv2"
      character_set = "utf8"
      description   = "db2"
    },
  ]
  #################
  # Rds Database account
  #################
  account_name     = "account_name1"
  account_password = "yourpassword123"
  tags = {
    Env      = "Private"
    Location = "Secret"
  }
  #############
  # cms_alarm
  #############
  alarm_rule_name            = "CmsAlarmForMysql"
  alarm_rule_statistics      = "Average"
  alarm_rule_period          = 300
  alarm_rule_operator        = "<="
  alarm_rule_threshold       = 35
  alarm_rule_triggered_count = 2
  alarm_rule_contact_groups  = ["MySQL", "AccCms"]
}
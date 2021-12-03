variable "region" {
  default = "cn-beijing"
}
variable "profile" {
  default = "default"
}
provider "alicloud" {
  region  = var.region
  profile = var.profile
}
data "alicloud_vpcs" "default" {
  is_default = true
}
data "alicloud_zones" "default" {
  available_resource_creation = "KVStore"
  multi                       = true
  enable_details              = true
}
resource "alicloud_vpc" "default" {
  count = length(data.alicloud_vpcs.default.ids) > 0 ? 0 : 1
  cidr_block = "172.16.0.0/12"
  vpc_name = "test_vpc_007"
}
data "alicloud_vswitches" "default" {
  zone_id = data.alicloud_zones.default.zones.0.multi_zone_ids.0
  vpc_id =  length(data.alicloud_vpcs.default.ids) > 0 ? "${data.alicloud_vpcs.default.ids.0}" : alicloud_vpc.default.0.id
}
resource "alicloud_vswitch" "default" {
  count = length(data.alicloud_vswitches.default.ids) > 0 ? 0:1
  vpc_id     = length(data.alicloud_vpcs.default.ids) > 0 ?  data.alicloud_vpcs.default.ids.0 :  alicloud_vpc.default.0.id
  cidr_block =  cidrsubnet(data.alicloud_vpcs.default.vpcs.0.cidr_block, 5, 11)
  zone_id    = data.alicloud_zones.default.zones[0].id
}

module "security_group" {
  source  = "alibaba/security-group/alicloud"
  region  = var.region
  profile = var.profile
  vpc_id  = length(data.alicloud_vpcs.default.ids) > 0 ?  data.alicloud_vpcs.default.vpcs.0.id : alicloud_vpc.default.0.id
}

module "mysql" {
  source  = "../../modules/mysql-5.7-basic"
  region  = var.region
  profile = var.profile

  #################
  # Rds Instance
  #################
  vswitch_id         = length(data.alicloud_vswitches.default.ids) > 0 ? data.alicloud_vswitches.default.ids.0 : alicloud_vswitch.default.0.id
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
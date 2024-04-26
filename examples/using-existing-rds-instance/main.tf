variable "region" {
  default = "eu-central-1"
}
variable "profile" {
  default = "default"
}
provider "alicloud" {
  region = var.region
}

data "alicloud_db_zones" "default" {
  engine                   = "MySQL"
  engine_version           = "8.0"
  instance_charge_type     = "PostPaid"
  category                 = "Basic"
  db_instance_storage_type = "cloud_essd"
}

data "alicloud_cms_alarm_contact_groups" "default" {
}

data "alicloud_db_instance_classes" "default" {
  zone_id                  = data.alicloud_db_zones.default.zones.0.id
  engine                   = "MySQL"
  engine_version           = "8.0"
  category                 = "Basic"
  db_instance_storage_type = "cloud_essd"
  instance_charge_type     = "PostPaid"
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

resource "alicloud_db_instance" "default" {
  engine                   = "MySQL"
  engine_version           = "8.0"
  instance_type            = data.alicloud_db_instance_classes.default.instance_classes.0.instance_class
  instance_storage         = data.alicloud_db_instance_classes.default.instance_classes.0.storage_range.min
  instance_charge_type     = "Postpaid"
  instance_name            = "terraform-example"
  vswitch_id               = module.vpc.vswitch_ids.0
  monitoring_period        = "60"
  db_instance_storage_type = "cloud_essd"
  security_group_ids       = [module.security_group.this_security_group_id]
}


module "mysql" {
  source  = "../../"
  region  = var.region
  profile = var.profile
  #################
  # Rds Instance
  #################
  create_instance      = false
  existing_instance_id = alicloud_db_instance.default.id
  ################
  # Backup Policy
  ################
  create_backup_policy        = true
  preferred_backup_period     = ["Monday", "Wednesday"]
  preferred_backup_time       = "00:00Z-01:00Z"
  backup_retention_period     = 7
  log_backup_retention_period = 7
  enable_backup_log           = true
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
      name          = "mysqldb"
      character_set = "utf8"
      description   = "db1"
    }
  ]
  #################
  # Rds Database account
  #################
  account_name     = "account_name"
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
  enable_alarm_rule          = true
}

locals {
  engine                = "MySQL"
  this_instance_id      = var.existing_instance_id != "" ? var.existing_instance_id : concat(alicloud_db_instance.this.*.id, [""])[0]
  create_more_resources = var.create_instance
  create_account        = local.create_more_resources && var.create_account
  create_database       = local.create_more_resources && var.create_database
  create_backup_policy  = local.create_more_resources && var.create_backup_policy
  project               = "acs_rds_dashboard"
}

module "databases" {
  source = "./modules/database"

  create_database = local.create_database
  create_account  = local.create_account

  databases      = var.databases
  db_instance_id = local.this_instance_id
  account_name   = var.account_name
  password       = var.account_password
  type           = var.account_type
  privilege      = var.account_privilege

}

resource "alicloud_db_instance" "this" {
  count                = var.create_instance ? 1 : 0
  engine               = local.engine
  engine_version       = var.engine_version
  instance_name        = var.instance_name
  instance_type        = var.instance_type
  instance_storage     = var.instance_storage
  instance_charge_type = var.instance_charge_type
  period               = var.period
  security_ips         = length(var.security_ips) > 0 ? var.security_ips : null
  vswitch_id           = var.vswitch_id
  security_group_ids   = var.security_group_ids
  tags = merge(
    {
      Name   = var.instance_name
      Engine = local.engine
    },
    var.tags,
  )
}

resource "alicloud_db_backup_policy" "this" {
  count                       = local.create_backup_policy ? 1 : 0
  instance_id                 = local.this_instance_id
  backup_retention_period     = var.backup_retention_period
  log_backup_retention_period = var.log_backup_retention_period
  preferred_backup_time       = var.preferred_backup_time
  preferred_backup_period     = var.preferred_backup_period
  enable_backup_log           = var.enable_backup_log
}

resource "alicloud_db_connection" "db_connection" {
  count             = local.create_more_resources && var.allocate_public_connection ? 1 : 0
  instance_id       = local.this_instance_id
  connection_prefix = var.connection_prefix
  port              = var.port
}

resource "alicloud_cms_alarm" "cpu_usage" {
  count   = local.create_more_resources && var.enable_alarm_rule ? 1 : 0
  enabled = var.enable_alarm_rule
  name    = var.alarm_rule_name
  project = local.project
  metric  = "CpuUsage"
  dimensions = {
    instanceId = local.this_instance_id
    device     = "/dev/vda1,/dev/vdb1"
  }
  escalations_critical {
    statistics          = var.alarm_rule_statistics
    comparison_operator = var.alarm_rule_operator
    threshold           = var.alarm_rule_threshold
    times               = var.alarm_rule_triggered_count
  }
  period             = var.alarm_rule_period
  contact_groups     = var.alarm_rule_contact_groups
  silence_time       = var.alarm_rule_silence_time
  effective_interval = var.alarm_rule_effective_interval
}

resource "alicloud_cms_alarm" "disk_usage" {
  count   = local.create_more_resources && var.enable_alarm_rule ? 1 : 0
  enabled = var.enable_alarm_rule
  name    = var.alarm_rule_name
  project = local.project
  metric  = "DiskUsage"
  dimensions = {
    instanceId = local.this_instance_id
    device     = "/dev/vda1,/dev/vdb1"
  }
  escalations_critical {
    statistics          = var.alarm_rule_statistics
    comparison_operator = var.alarm_rule_operator
    threshold           = var.alarm_rule_threshold
    times               = var.alarm_rule_triggered_count
  }
  period             = var.alarm_rule_period
  contact_groups     = var.alarm_rule_contact_groups
  silence_time       = var.alarm_rule_silence_time
  effective_interval = var.alarm_rule_effective_interval
}

resource "alicloud_cms_alarm" "memory_usage" {
  count   = local.create_more_resources && var.enable_alarm_rule ? 1 : 0
  enabled = var.enable_alarm_rule
  name    = var.alarm_rule_name
  project = local.project
  metric  = "MemoryUsage"
  dimensions = {
    instanceId = local.this_instance_id
    device     = "/dev/vda1,/dev/vdb1"
  }
  escalations_critical {
    statistics          = var.alarm_rule_statistics
    comparison_operator = var.alarm_rule_operator
    threshold           = var.alarm_rule_threshold
    times               = var.alarm_rule_triggered_count
  }
  period             = var.alarm_rule_period
  contact_groups     = var.alarm_rule_contact_groups
  silence_time       = var.alarm_rule_silence_time
  effective_interval = var.alarm_rule_effective_interval
}

resource "alicloud_cms_alarm" "network_in_new" {
  count   = local.create_more_resources && var.enable_alarm_rule ? 1 : 0
  enabled = var.enable_alarm_rule
  name    = var.alarm_rule_name
  project = local.project
  metric  = "MySQL_NetworkInNew"
  dimensions = {
    instanceId = local.this_instance_id
    device     = "/dev/vda1,/dev/vdb1"
  }
  escalations_critical {
    statistics          = var.alarm_rule_statistics
    comparison_operator = var.alarm_rule_operator
    threshold           = var.alarm_rule_threshold
    times               = var.alarm_rule_triggered_count
  }
  period             = var.alarm_rule_period
  contact_groups     = var.alarm_rule_contact_groups
  silence_time       = var.alarm_rule_silence_time
  effective_interval = var.alarm_rule_effective_interval
}

resource "alicloud_cms_alarm" "network_out_new" {
  count   = local.create_more_resources && var.enable_alarm_rule ? 1 : 0
  enabled = var.enable_alarm_rule
  name    = var.alarm_rule_name
  project = local.project
  metric  = "MySQL_NetworkOutNew"
  dimensions = {
    instanceId = local.this_instance_id
    device     = "/dev/vda1,/dev/vdb1"
  }
  escalations_critical {
    statistics          = var.alarm_rule_statistics
    comparison_operator = var.alarm_rule_operator
    threshold           = var.alarm_rule_threshold
    times               = var.alarm_rule_triggered_count
  }
  period             = var.alarm_rule_period
  contact_groups     = var.alarm_rule_contact_groups
  silence_time       = var.alarm_rule_silence_time
  effective_interval = var.alarm_rule_effective_interval
}
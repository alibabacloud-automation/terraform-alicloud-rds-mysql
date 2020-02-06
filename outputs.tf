############
# cms alarm
############
output "this_alarm_rule_id" {
  description = "The ID of the alarm rule. "
  value       = concat(alicloud_cms_alarm.cpu_usage.*.id, [""])[0]
}
output "this_alarm_rule_name" {
  description = "The alarm name. "
  value       = concat(alicloud_cms_alarm.cpu_usage.*.name, [""])[0]
}
output "this_alarm_rule_project" {
  description = "Monitor project name. "
  value       = concat(alicloud_cms_alarm.cpu_usage.*.project, [""])[0]
}
output "this_alarm_rule_metric" {
  description = "Name of the monitoring metrics. "
  value       = concat(alicloud_cms_alarm.cpu_usage.*.metric, [""])[0]
}
output "this_alarm_rule_dimensions" {
  description = "Map of the resources associated with the alarm rule. "
  value       = alicloud_cms_alarm.cpu_usage.*.dimensions
}
output "this_alarm_rule_period" {
  description = "Index query cycle. "
  value       = concat(alicloud_cms_alarm.cpu_usage.*.period, [""])[0]
}
output "this_alarm_rule_statistics" {
  description = "Statistical method. "
  value       = concat(alicloud_cms_alarm.cpu_usage.*.statistics, [""])[0]
}
output "this_alarm_rule_operator" {
  description = "Alarm comparison operator. "
  value       = concat(alicloud_cms_alarm.cpu_usage.*.operator, [""])[0]
}
output "this_alarm_rule_threshold" {
  description = "Alarm threshold value."
  value       = concat(alicloud_cms_alarm.cpu_usage.*.threshold, [""])[0]
}
output "this_alarm_rule_triggered_count" {
  description = "Number of trigger alarm. "
  value       = concat(alicloud_cms_alarm.cpu_usage.*.triggered_count, [""])[0]
}
output "this_alarm_rule_contact_groups" {
  description = "List contact groups of the alarm rule. "
  value       = concat(alicloud_cms_alarm.cpu_usage.*.contact_groups, [""])[0]
}
output "this_alarm_rule_silence_time" {
  description = " Notification silence period in the alarm state. "
  value       = concat(alicloud_cms_alarm.cpu_usage.*.silence_time, [""])[0]
}
output "this_alarm_rule_notify_type" {
  description = "Notification type. "
  value       = concat(alicloud_cms_alarm.cpu_usage.*.notify_type, [""])[0]
}
output "this_alarm_rule_enabled" {
  description = "Whether to enable alarm rule. "
  value       = concat(alicloud_cms_alarm.cpu_usage.*.enabled, [""])[0]
}
output "this_alarm_rule_webhook" {
  description = "The webhook that is called when the alarm is triggered. "
  value       = concat(alicloud_cms_alarm.cpu_usage.*.webhook, [""])[0]
}
output "this_alarm_rule_cpu_usage_status" {
  description = "The current alarm cpu usage rule status. "
  value       = concat(alicloud_cms_alarm.cpu_usage.*.status, [""])[0]
}
output "this_alarm_rule_disk_usage_status" {
  description = "The current alarm disk usage rule status. "
  value       = concat(alicloud_cms_alarm.disk_usage.*.status, [""])[0]
}
output "this_alarm_rule_memory_usage_status" {
  description = "The current alarm memory usage rule status. "
  value       = concat(alicloud_cms_alarm.memory_usage.*.status, [""])[0]
}
output "this_alarm_rule_network_in_new_status" {
  description = "The current alarm network in new rule status. "
  value       = concat(alicloud_cms_alarm.network_in_new.*.status, [""])[0]
}
output "this_alarm_rule_network_out_new_status" {
  description = "The current alarm network out new rule status. "
  value       = concat(alicloud_cms_alarm.network_out_new.*.status, [""])[0]
}

#################
# MySQL Instance
#################
output "this_db_instance_id" {
  description = "MySQL instance id."
  value       = local.this_instance_id
}
output "this_db_instance_engine" {
  description = "MySQL instance engine."
  value       = concat(alicloud_db_instance.this.*.engine, [""])[0]
}
output "this_db_instance_engine_version" {
  description = "MySQL instance engine version."
  value       = concat(alicloud_db_instance.this.*.engine_version, [""])[0]
}
output "this_db_instance_type" {
  description = "MySQL instance type."
  value       = concat(alicloud_db_instance.this.*.instance_type, [""])[0]
}
output "this_db_instance_storage" {
  description = "MySQL instance storage."
  value       = concat(alicloud_db_instance.this.*.instance_storage, [""])[0]
}
output "this_db_instance_charge_type" {
  description = "MySQL instance charge type."
  value       = concat(alicloud_db_instance.this.*.instance_charge_type, [""])[0]
}
output "this_db_instance_name" {
  description = "MySQL instance name."
  value       = concat(alicloud_db_instance.this.*.instance_name, [""])[0]
}
output "this_db_instance_period" {
  description = "MySQL instance charge period when Prepaid."
  value       = concat(alicloud_db_instance.this.*.period, [""])[0]
}
output "this_db_instance_security_ips" {
  description = "MySQL instance security ip list."
  value       = concat(alicloud_db_instance.this.*.security_ips, [""])[0]
}
output "this_db_instance_zone_id" {
  description = "The zone id in which the Rds instance."
  value       = concat(alicloud_db_instance.this.*.zone_id, [""])[0]
}
output "this_db_instance_vswitch_id" {
  description = "The vswitch id in which the Rds instance."
  value       = concat(alicloud_db_instance.this.*.vswitch_id, [""])[0]
}
output "this_db_instance_security_group_ids" {
  description = "The security group ids in which the Rds instance."
  value       = alicloud_db_instance.this.*.security_group_id
}
output "this_db_instance_tags" {
  description = "MySQL instance tags"
  value       = alicloud_db_instance.this.*.tags
}

#################
# MySQL instance connection
#################

output "this_db_instance_connection_string" {
  description = "MySQL instance public connection string"
  value       = concat(alicloud_db_instance.this.*.connection_string, [""])[0]
}
output "this_db_instance_port" {
  description = "MySQL instance public connection string"
  value       = concat(alicloud_db_instance.this.*.port, [""])[0]
}
output "this_db_instance_connection_ip_address" {
  description = "MySQL instance public connection string's ip address"
  value       = concat(alicloud_db_connection.db_connection.*.ip_address, [""])[0]
}

#################
# MySQL database
#################
output "this_db_database_description" {
  description = "MySQL database description."
  value       = module.databases.this_database_description
}
output "this_db_database_id" {
  description = "MySQL database id."
  value       = module.databases.this_database_id
}
output "this_db_database_name" {
  description = "MySQL database name."
  value       = module.databases.this_database_name
}

#################
# MySQL database account
#################
output "this_db_database_account" {
  description = "MySQL database account."
  value       = module.databases.this_database_account
}
output "this_db_database_account_privilege" {
  description = "MySQL database account privilege."
  value       = module.databases.this_database_account_privilege
}
output "this_db_database_account_type" {
  description = "MySQL database account type."
  value       = module.databases.this_database_account_type
}

############
# cms alarm
############
output "this_alarm_rule_effective_interval" {
  description = "The interval of effecting alarm rule. "
  value       = module.mysql.this_alarm_rule_effective_interval
}
output "this_alarm_rule_id" {
  description = "The ID of the alarm rule. "
  value       = module.mysql.this_alarm_rule_id
}
output "this_alarm_rule_name" {
  description = "The alarm name. "
  value       = module.mysql.this_alarm_rule_name
}
output "this_alarm_rule_project" {
  description = "Monitor project name. "
  value       = module.mysql.this_alarm_rule_project
}
output "this_alarm_rule_metric" {
  description = "Name of the monitoring metrics. "
  value       = module.mysql.this_alarm_rule_metric
}
output "this_alarm_rule_dimensions" {
  description = "Map of the resources associated with the alarm rule. "
  value       = module.mysql.this_alarm_rule_dimensions
}
output "this_alarm_rule_period" {
  description = "Index query cycle. "
  value       = module.mysql.this_alarm_rule_period
}
output "this_alarm_rule_statistics" {
  description = "Statistical method. "
  value       = module.mysql.this_alarm_rule_statistics
}
output "this_alarm_rule_operator" {
  description = "Alarm comparison operator. "
  value       = module.mysql.this_alarm_rule_operator
}
output "this_alarm_rule_threshold" {
  description = "Alarm threshold value."
  value       = module.mysql.this_alarm_rule_threshold
}
output "this_alarm_rule_triggered_count" {
  description = "Number of trigger alarm. "
  value       = module.mysql.this_alarm_rule_triggered_count
}
output "this_alarm_rule_contact_groups" {
  description = "List contact groups of the alarm rule. "
  value       = module.mysql.this_alarm_rule_contact_groups
}
output "this_alarm_rule_silence_time" {
  description = " Notification silence period in the alarm state. "
  value       = module.mysql.this_alarm_rule_silence_time
}
output "this_alarm_rule_notify_type" {
  description = "Notification type. "
  value       = module.mysql.this_alarm_rule_notify_type
}
output "this_alarm_rule_enabled" {
  description = "Whether to enable alarm rule. "
  value       = module.mysql.this_alarm_rule_enabled
}
output "this_alarm_rule_webhook" {
  description = "The webhook that is called when the alarm is triggered. "
  value       = module.mysql.this_alarm_rule_webhook
}
output "this_alarm_rule_cpu_usage_status" {
  description = "The current alarm cpu usage rule status. "
  value       = module.mysql.this_alarm_rule_cpu_usage_status
}
output "this_alarm_rule_disk_usage_status" {
  description = "The current alarm disk usage rule status. "
  value       = module.mysql.this_alarm_rule_disk_usage_status
}
output "this_alarm_rule_memory_usage_status" {
  description = "The current alarm memory usage rule status. "
  value       = module.mysql.this_alarm_rule_memory_usage_status
}
output "this_alarm_rule_network_in_new_status" {
  description = "The current alarm network in new rule status. "
  value       = module.mysql.this_alarm_rule_network_in_new_status
}
output "this_alarm_rule_network_out_new_status" {
  description = "The current alarm network out new rule status. "
  value       = module.mysql.this_alarm_rule_network_out_new_status
}

#################
# MySQL Instance
#################

output "this_db_instance_id" {
  description = "MySQL instance id."
  value       = module.mysql.this_db_instance_id
}
output "this_db_instance_engine" {
  description = "MySQL instance engine."
  value       = module.mysql.this_db_instance_engine
}
output "this_db_instance_engine_version" {
  description = "MySQL instance engine version."
  value       = module.mysql.this_db_instance_engine_version
}
output "this_db_instance_type" {
  description = "MySQL instance type."
  value       = module.mysql.this_db_instance_type
}
output "this_db_instance_storage" {
  description = "MySQL instance storage."
  value       = module.mysql.this_db_instance_storage
}
output "this_db_instance_charge_type" {
  description = "MySQL instance charge type."
  value       = module.mysql.this_db_instance_charge_type
}
output "this_db_instance_name" {
  description = "MySQL instance name."
  value       = module.mysql.this_db_instance_name
}
output "this_db_instance_period" {
  description = "MySQL instance charge period when Prepaid."
  value       = module.mysql.this_db_instance_period
}
output "this_db_instance_security_ips" {
  description = "MySQL instance security ip list."
  value       = module.mysql.this_db_instance_security_ips
}
output "this_db_instance_zone_id" {
  description = "The zone id in which the Rds instance."
  value       = module.mysql.this_db_instance_zone_id
}
output "this_db_instance_vswitch_id" {
  description = "The vswitch id in which the Rds instance."
  value       = module.mysql.this_db_instance_vswitch_id
}
output "this_db_instance_security_group_ids" {
  description = "The security group ids in which the Rds instance."
  value       = module.mysql.this_db_instance_security_group_ids
}
output "this_db_instance_tags" {
  description = "MySQL instance tags"
  value       = module.mysql.this_db_instance_tags
}

#################
# MySQL instance connection
#################

output "this_db_instance_connection_string" {
  description = "MySQL instance public connection string"
  value       = module.mysql.this_db_instance_connection_string
}
output "this_db_instance_port" {
  description = "MySQL instance public connection string"
  value       = module.mysql.this_db_instance_port
}
output "this_db_instance_connection_ip_address" {
  description = "MySQL instance public connection string's ip address"
  value       = module.mysql.this_db_instance_connection_ip_address
}

#################
# MySQL database
#################

output "this_db_database_description" {
  description = "MySQL database description."
  value       = module.mysql.this_db_database_description
}
output "this_db_database_id" {
  description = "MySQL database id."
  value       = module.mysql.this_db_database_id
}
output "this_db_database_name" {
  description = "MySQL database name."
  value       = module.mysql.this_db_database_name
}

#################
# MySQL database account
#################

output "this_db_database_account" {
  description = "MySQL database account."
  value       = module.mysql.this_db_database_account
}
output "this_db_database_account_privilege" {
  description = "MySQL database account privilege."
  value       = module.mysql.this_db_database_account_privilege
}
output "this_db_database_account_type" {
  description = "MySQL database account type."
  value       = module.mysql.this_db_database_account_type
}

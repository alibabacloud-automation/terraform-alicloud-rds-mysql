#################
# MySQL Database
#################
description = "update-tf-testacc-description"

#################
# MySQL Database account
#################
account_password = "YourPassword123!update"

#################
# Mysql Instance
#################
instance_name    = "update-tf-testacc-name"
instance_storage = 25
period           = 2
security_ips     = ["10.23.12.24"]
tags = {
  Name = "updateRDS"
}

#################
# MySQL Backup policy
#################
backup_retention_period     = 8
log_backup_retention_period = 8
preferred_backup_time       = "01:00Z-02:00Z"
preferred_backup_period     = ["Tuesday", "Wednesday"]
enable_backup_log           = false

#############
# cms_alarm
#############
enable_alarm_rule             = false
alarm_rule_name               = "update-tf-testacc-rule"
alarm_rule_period             = 900
alarm_rule_statistics         = "Maximum"
alarm_rule_operator           = "<="
alarm_rule_threshold          = "35"
alarm_rule_triggered_count    = 5
alarm_rule_silence_time       = 10000
alarm_rule_effective_interval = "1:00-3:00"
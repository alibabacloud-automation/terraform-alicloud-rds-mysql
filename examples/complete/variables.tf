#################
# MySQL Database
#################
variable "description" {
  description = "Database description."
  type        = string
  default     = "tf-testacc-description"
}

#################
# MySQL Database account
#################
variable "account_password" {
  description = "Operation database account password. It may consist of letters, digits, or underlines, with a length of 6 to 32 characters."
  type        = string
  default     = "YourPassword123!"
}

#################
# Mysql Instance
#################
variable "instance_name" {
  description = "The name of MySQL Instance."
  type        = string
  default     = "tf-testacc-name"
}

variable "instance_storage" {
  description = "The storage capacity of the instance. Unit: GB. The storage capacity increases at increments of 5 GB. For more information, see [Instance Types](https://www.alibabacloud.com/help/doc-detail/26312.htm)."
  type        = number
  default     = 20
}

variable "instance_charge_type" {
  description = "The instance charge type. Valid values: Prepaid and Postpaid. Default to Postpaid."
  type        = string
  default     = "Postpaid"
}

variable "period" {
  description = "The duration that you will buy MySQL Instance (in month). It is valid when instance_charge_type is PrePaid. Valid values: [1~9], 12, 24, 36. Default to 1"
  type        = number
  default     = 1
}

variable "security_ips" {
  description = " List of IP addresses allowed to access all databases of an instance. The list contains up to 1,000 IP addresses, separated by commas. Supported formats include 0.0.0.0/0, 10.23.12.24 (IP), and 10.23.12.24/24 (Classless Inter-Domain Routing (CIDR) mode. /24 represents the length of the prefix in an IP address. The range of the prefix length is [1,32])."
  type        = list(string)
  default     = ["127.0.0.1"]
}

variable "tags" {
  description = "A mapping of tags to assign to the mysql."
  type        = map(string)
  default = {
    Name = "RDS"
  }
}

#################
# MySQL Backup policy
#################
variable "backup_retention_period" {
  description = "Instance backup retention days. Valid values: [7-730]. Default to 7."
  type        = number
  default     = 7
}

variable "log_backup_retention_period" {
  description = "Instance log backup retention days. Valid values: [7-730]. Default to 7. It can be larger than 'retention_period'."
  type        = number
  default     = 7
}

variable "preferred_backup_time" {
  description = " MySQL Instance backup time, in the format of HH:mmZ- HH:mmZ. "
  type        = string
  default     = "02:00Z-03:00Z"
}

variable "preferred_backup_period" {
  description = "MySQL Instance backup period."
  type        = list(string)
  default     = ["Monday", "Tuesday"]
}

variable "enable_backup_log" {
  description = "Whether to backup instance log. Default to true."
  type        = bool
  default     = true
}

#############
# cms_alarm
#############
variable "enable_alarm_rule" {
  description = "Whether to enable alarm rule. Default to true. "
  type        = bool
  default     = true
}

variable "alarm_rule_name" {
  description = "The alarm rule name. "
  type        = string
  default     = "tf-testacc-rule"
}

variable "alarm_rule_period" {
  description = "Index query cycle, which must be consistent with that defined for metrics. Default to 300, in seconds. "
  type        = number
  default     = 300
}

variable "alarm_rule_statistics" {
  description = "Statistical method. It must be consistent with that defined for metrics. Valid values: ['Average', 'Minimum', 'Maximum']. Default to 'Average'. "
  type        = string
  default     = "Average"
}

variable "alarm_rule_operator" {
  description = "Alarm comparison operator. Valid values: ['<=', '<', '>', '>=', '==', '!=']. Default to '=='. "
  type        = string
  default     = ">="
}

variable "alarm_rule_threshold" {
  description = "Alarm threshold value, which must be a numeric value currently. "
  type        = string
  default     = "90"
}

variable "alarm_rule_triggered_count" {
  description = "Number of consecutive times it has been detected that the values exceed the threshold. Default to 3. "
  type        = number
  default     = 3
}

variable "alarm_rule_silence_time" {
  description = "Notification silence period in the alarm state, in seconds. Valid value range: [300, 86400]. Default to 86400. "
  type        = number
  default     = 86400
}

variable "alarm_rule_effective_interval" {
  description = "The interval of effecting alarm rule. It foramt as 'hh:mm-hh:mm', like '0:00-4:00'."
  type        = string
  default     = "0:00-2:00"
}
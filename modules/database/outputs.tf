#db_database
output "this_database_description" {
  description = "MySQL database description."
  value       = alicloud_db_database.this.*.description
}
output "this_database_id" {
  description = "MySQL database id."
  value       = alicloud_db_database.this.*.id
}
output "this_database_name" {
  description = "MySQL database name."
  value       = alicloud_db_database.this.*.name
}
output "this_database_account" {
  description = "MySQL database account."
  value       = concat(alicloud_db_account.this.*.name, [""])[0]
}
output "this_database_account_type" {
  description = "MySQL database account type."
  value       = concat(alicloud_db_account.this.*.type, [""])[0]
}
output "this_database_account_privilege" {
  description = "MySQL database account privilege."
  value       = concat(alicloud_db_account_privilege.this.*.privilege, [""])[0]
}


Terraform module which create a MySql database based on Alibaba Cloud RDS Service.   
terraform-alicloud-rds-mysql
-------

English | [简体中文](https://github.com/terraform-alicloud-modules/terraform-alicloud-rds-mysql/blob/master/README-CN.md)

Terraform module which creates RDS-MySQL database and sets CMS alarm for it on Alibaba Cloud. 

These types of resources are supported:

* [Alicloud_db_instance](https://www.terraform.io/docs/providers/alicloud/r/db_instance.html)
* [Alicloud_db_account](https://www.terraform.io/docs/providers/alicloud/r/db_account.html)
* [Alicloud_db_database](https://www.terraform.io/docs/providers/alicloud/r/db_database.html)
* [Alicloud_db_backup_policy](https://www.terraform.io/docs/providers/alicloud/r/db_backup_policy.html)
* [Alicloud_cms_alarm](https://www.terraform.io/docs/providers/alicloud/r/cms_alarm.html)


## Terraform versions

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.56.0 |

## Usage

For new instance

```hcl
module "mysql" {
  source    = "terraform-alicloud-modules/rds-mysql/alicloud"

  ###############
  #Rds Instance#
  ###############
  
  engine_version       = "5.7"
  connection_prefix    = "developmentabc"
  vswitch_id           = "vsw-bp1tili2u5kxxxxxx"
  instance_storage     = 20
  period               = 1
  instance_type        = "rds.mysql.s2.large"
  instance_name        = "myDBInstance"
  instance_charge_type = "Postpaid"
  security_ips = [
    "11.193.54.0/24",
    "121.43.18.0/24"
    ]
    
  tags = {
    Created      = "Terraform"
    Environment = "dev"
  }
  
  ###############
  #backup_policy#
  ###############

  preferred_backup_period     = ["Monday", "Wednesday"]
  preferred_backup_time       = "00:00Z-01:00Z"
  backup_retention_period     = 7
  log_backup_retention_period = 7
  enable_backup_log           = true
  
  ###########
  #databases#
  ###########

  account_name         = "account_name1"
  account_password     = "1234abc"
  account_type         = "Normal"
  account_privilege    = "ReadWrite"
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
```

For existing instance

```hcl

module "mysql" {
  source    = "terraform-alicloud-modules/rds-mysql/alicloud"

  #################
  # Rds Instance
  #################
  existing_instance_id="rm-2ze9tmt47xxxxxxx"

  ################
  # Backup Policy
  ################

  create_backup_policy        =true
  preferred_backup_period     = ["Monday", "Wednesday"]
  preferred_backup_time       = "00:00Z-01:00Z"
  backup_retention_period     = 7
  log_backup_retention_period = 7
  enable_backup_log           = true

  ##############
  # connection
  ##############
  allocate_public_connection  = false
  connection_prefix           = "mysqlconnection"

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
  enable_alarm_rule=true
}
```

## Examples

* [Complete Example](https://github.com/terraform-alicloud-modules/terraform-alicloud-rds-mysql/tree/master/examples/complete)
* [Using exising Rds Instance Example](https://github.com/terraform-alicloud-modules/terraform-alicloud-rds-mysql/tree/master/examples/using-existing-rds-instance)

## Modules

* [database](https://github.com/terraform-alicloud-modules/terraform-alicloud-rds-mysql/tree/master/modules/database)
* [mysql-5.5-high-availability](https://github.com/terraform-alicloud-modules/terraform-alicloud-rds-mysql/tree/master/modules/mysql-5.5-high-availability)
* [mysql-5.6-enterprise](https://github.com/terraform-alicloud-modules/terraform-alicloud-rds-mysql/tree/master/modules/mysql-5.6-enterprise)
* [mysql-5.6-high-availability](https://github.com/terraform-alicloud-modules/terraform-alicloud-rds-mysql/tree/master/modules/mysql-5.6-high-availability)
* [mysql-5.7-basic](https://github.com/terraform-alicloud-modules/terraform-alicloud-rds-mysql/tree/master/modules/mysql-5.7-basic)
* [mysql-5.7-enterprise](https://github.com/terraform-alicloud-modules/terraform-alicloud-rds-mysql/tree/master/modules/mysql-5.7-enterprise)
* [mysql-5.7-high-availability](https://github.com/terraform-alicloud-modules/terraform-alicloud-rds-mysql/tree/master/modules/mysql-5.7-high-availability)
* [mysql-8.0-basic](https://github.com/terraform-alicloud-modules/terraform-alicloud-rds-mysql/tree/master/modules/mysql-8.0-basic)
* [mysql-8.0-enterprise](https://github.com/terraform-alicloud-modules/terraform-alicloud-rds-mysql/tree/master/modules/mysql-8.0-enterprise)
* [mysql-8.0-high-availability](https://github.com/terraform-alicloud-modules/terraform-alicloud-rds-mysql/tree/master/modules/mysql-8.0-high-availability)

## Notes
From the version v1.4.0, the module has removed the following `provider` setting:

```hcl
provider "alicloud" {
  profile                 = var.profile != "" ? var.profile : null
  shared_credentials_file = var.shared_credentials_file != "" ? var.shared_credentials_file : null
  region                  = var.region != "" ? var.region : null
  skip_region_validation  = var.skip_region_validation
  configuration_source    = "terraform-alicloud-modules/rds-mysql"
}
```

If you still want to use the `provider` setting to apply this module, you can specify a supported version, like 1.3.0:

```hcl
module "rds-mysql" {
  source  = "terraform-alicloud-modules/rds-mysql/alicloud"
  version     = "1.3.0"
  region      = "cn-hangzhou"
  profile     = "Your-Profile-Name"
  create_backup_policy        =true
  preferred_backup_period     = ["Monday", "Wednesday"]
  preferred_backup_time       = "00:00Z-01:00Z"
  backup_retention_period     = 7
  log_backup_retention_period = 7
  enable_backup_log           = true
}
```

If you want to upgrade the module to 1.4.0 or higher in-place, you can define a provider which same region with
previous region:

```hcl
provider "alicloud" {
   region  = "cn-hangzhou"
   profile = "Your-Profile-Name"
}
module "rds-mysql" {
  source  = "terraform-alicloud-modules/rds-mysql/alicloud"
  create_backup_policy        =true
  preferred_backup_period     = ["Monday", "Wednesday"]
  preferred_backup_time       = "00:00Z-01:00Z"
  backup_retention_period     = 7
  log_backup_retention_period = 7
  enable_backup_log           = true
}
```
or specify an alias provider with a defined region to the module using `providers`:

```hcl
provider "alicloud" {
  region  = "cn-hangzhou"
  profile = "Your-Profile-Name"
  alias   = "hz"
}
module "rds-mysql" {
  source  = "terraform-alicloud-modules/rds-mysql/alicloud"
  providers = {
    alicloud = alicloud.hz
  }

}
```

Submit Issues
-------------
If you have any problems when using this module, please opening a [provider issue](https://github.com/terraform-providers/terraform-provider-alicloud/issues/new) and let us know.

**Note:** There does not recommend to open an issue on this repo.

Authors
-------
Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com)

License
----
Apache 2 Licensed. See LICENSE for full details.

Reference
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)


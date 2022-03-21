terraform-alicloud-rds-mysql
-------

本 Module 用于在阿里云的 VPC 下创建一个[MySQL云数据库](https://help.aliyun.com/document_detail/26092.html)，并为其配置云监控。

本 Module 支持创建以下资源:

* [MySQL 数据库实例 (db_instance)](https://www.terraform.io/docs/providers/alicloud/r/db_instance.html)
* [Account 数据库用户实例 (db_account)](https://www.terraform.io/docs/providers/alicloud/r/db_account.html)
* [Database 数据库实例 (db_database)](https://www.terraform.io/docs/providers/alicloud/r/db_database.html)
* [BackupPolicy 备份实例 (db_backup_policy)](https://www.terraform.io/docs/providers/alicloud/r/db_backup_policy.html)
* [CmsAlarm 云监控实例 (cms_alarm)](https://www.terraform.io/docs/providers/alicloud/r/cms_alarm.html)

## Terraform 版本

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.56.0 |

## 用法

#### 创建新的Rds实例

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

### 使用已经存在的Rds实例

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

## 示例

* [创建 MySql 完整示例](https://github.com/terraform-alicloud-modules/terraform-alicloud-rds-mysql/tree/master/examples/complete)
* [使用已经存在的 Rds 实例创建 MySql 示例](https://github.com/terraform-alicloud-modules/terraform-alicloud-rds-mysql/tree/master/examples/using-existing-rds-instance)

## 子模块

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

## 注意事项
本Module从版本v1.4.0开始已经移除掉如下的 provider 的显式设置：
```hcl
provider "alicloud" {
  profile                 = var.profile != "" ? var.profile : null
  shared_credentials_file = var.shared_credentials_file != "" ? var.shared_credentials_file : null
  region                  = var.region != "" ? var.region : null
  skip_region_validation  = var.skip_region_validation
  configuration_source    = "terraform-alicloud-modules/rds-mysql"
}
```

如果你依然想在Module中使用这个 provider 配置，你可以在调用Module的时候，指定一个特定的版本，比如 1.3.0:

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
如果你想对正在使用中的Module升级到 1.4.0 或者更高的版本，那么你可以在模板中显式定义一个相同Region的provider：
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
或者，如果你是多Region部署，你可以利用 `alias` 定义多个 provider，并在Module中显式指定这个provider：

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
  create_backup_policy        =true
  preferred_backup_period     = ["Monday", "Wednesday"]
  preferred_backup_time       = "00:00Z-01:00Z"
  backup_retention_period     = 7
  log_backup_retention_period = 7
  enable_backup_log           = true
}
```

定义完provider之后，运行命令 `terraform init` 和 `terraform apply` 来让这个provider生效即可。

更多provider的使用细节，请移步[How to use provider in the module](https://www.terraform.io/docs/language/modules/develop/providers.html#passing-providers-explicitly)

提交问题
------
如果在使用该 Terraform Module 的过程中有任何问题，可以直接创建一个 [Provider Issue](https://github.com/terraform-providers/terraform-provider-alicloud/issues/new)，我们将根据问题描述提供解决方案。

**注意:** 不建议在该 Module 仓库中直接提交 Issue。

作者
-------
Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com)

许可
----
Apache 2 Licensed. See LICENSE for full details.

参考
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)
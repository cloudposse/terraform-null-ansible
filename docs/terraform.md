<!-- markdownlint-disable -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |
| <a name="requirement_archive"></a> [archive](#requirement\_archive) | ~> 2.2.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | ~> 3.2.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.6.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | ~> 2.2.0 |
| <a name="provider_null"></a> [null](#provider\_null) | ~> 3.2.0 |
| <a name="provider_random"></a> [random](#provider\_random) | ~> 3.6.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [null_resource.cleanup](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.provisioner](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [random_id.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [archive_file.default](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_arguments"></a> [arguments](#input\_arguments) | Arguments | `list(string)` | `[]` | no |
| <a name="input_dry_run"></a> [dry\_run](#input\_dry\_run) | Do dry run | `bool` | `true` | no |
| <a name="input_envs"></a> [envs](#input\_envs) | Environment variables | `list(string)` | `[]` | no |
| <a name="input_playbook"></a> [playbook](#input\_playbook) | Playbook to run | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arguments"></a> [arguments](#output\_arguments) | Arguments |
| <a name="output_envs"></a> [envs](#output\_envs) | Environment variables |
<!-- markdownlint-restore -->

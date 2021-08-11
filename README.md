<!-- BEGIN_TF_DOCS -->
[![Tests](https://github.com/netascode/terraform-aci-management-access-policy/actions/workflows/test.yml/badge.svg)](https://github.com/netascode/terraform-aci-management-access-policy/actions/workflows/test.yml)

# Terraform ACI Management Access Policy Module

Manages ACI Management Access Policy

Location in GUI:
`Fabric` » `Fabric Policies` » `Policies` » `Pod` » `Management Access`

## Examples

```hcl
module "aci_management_access_policy" {
  source = "netascode/management-access-policy/aci"

  name        = "MAP1"
  description = "My Description"
  telnet = {
    admin_state = true
    port        = 2023
  }
  ssh = {
    admin_state   = true
    password_auth = true
    port          = 2022
    aes128_ctr    = false
    aes128_gcm    = false
    aes192_ctr    = false
    aes256_ctr    = false
    chacha        = false
    hmac_sha1     = false
    hmac_sha2_256 = false
    hmac_sha2_512 = false
  }
  https = {
    admin_state            = true
    client_cert_auth_state = false
    port                   = 2443
    dh                     = 2048
    tlsv1                  = true
    tlsv1_1                = true
    tlsv1_2                = false
    keyring                = "KR1"
  }
  http = {
    admin_state = true
    port        = 2080
  }
}

```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aci"></a> [aci](#requirement\_aci) | >= 0.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aci"></a> [aci](#provider\_aci) | >= 0.2.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | Management access policy name. | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | Description. | `string` | `""` | no |
| <a name="input_telnet"></a> [telnet](#input\_telnet) | Telnet settings. Default value `admin_state`: `false`. Allowed values `port`: 1-65535. Default value `port`: 23. | <pre>object({<br>    admin_state = optional(bool)<br>    port        = optional(number)<br>  })</pre> | `{}` | no |
| <a name="input_ssh"></a> [ssh](#input\_ssh) | SSH settings. Default value `admin_state`: `true`. Default value `password_auth`: `true`. Allowed values `port`: 1-65535. Default value `port`: 22. Default value `aes128_ctr`: `true`. Default value `aes128_gcm`: `true`. Default value `aes192_ctr`: `true`. Default value `aes256_ctr`: `true`. Default value `chacha`: `true`. Default value `hmac_sha1`: `true`. Default value `hmac_sha2_256`: `true`. Default value `hmac_sha2_512`: `true`. | <pre>object({<br>    admin_state   = optional(bool)<br>    password_auth = optional(bool)<br>    port          = optional(number)<br>    aes128_ctr    = optional(bool)<br>    aes128_gcm    = optional(bool)<br>    aes192_ctr    = optional(bool)<br>    aes256_ctr    = optional(bool)<br>    chacha        = optional(bool)<br>    hmac_sha1     = optional(bool)<br>    hmac_sha2_256 = optional(bool)<br>    hmac_sha2_512 = optional(bool)<br>  })</pre> | `{}` | no |
| <a name="input_https"></a> [https](#input\_https) | HTTPS settings. Default value `admin_state`: `true`. Default value `client_cert_auth_state`: `false`. Allowed values `port`: 1-65535. Default value `port`: 443. Choices `dh`: `1024`, `2048`, `4096`, `none`. Default value `dh`: `none`. Default value `tlsv1`: `false`. Default value `tlsv1_1`: `true`. Default value `tlsv1_2`: `true`. | <pre>object({<br>    admin_state            = optional(bool)<br>    client_cert_auth_state = optional(bool)<br>    port                   = optional(number)<br>    dh                     = optional(string)<br>    tlsv1                  = optional(bool)<br>    tlsv1_1                = optional(bool)<br>    tlsv1_2                = optional(bool)<br>    keyring                = optional(string)<br>  })</pre> | `{}` | no |
| <a name="input_http"></a> [http](#input\_http) | HTTP settings. Default value `admin_state`: `false`. Allowed values `port`: 1-65535. Default value `port`: 80. | <pre>object({<br>    admin_state = optional(bool)<br>    port        = optional(number)<br>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dn"></a> [dn](#output\_dn) | Distinguished name of `commPol` object. |
| <a name="output_name"></a> [name](#output\_name) | Management access policy name. |

## Resources

| Name | Type |
|------|------|
| [aci_rest.commHttp](https://registry.terraform.io/providers/netascode/aci/latest/docs/resources/rest) | resource |
| [aci_rest.commHttps](https://registry.terraform.io/providers/netascode/aci/latest/docs/resources/rest) | resource |
| [aci_rest.commPol](https://registry.terraform.io/providers/netascode/aci/latest/docs/resources/rest) | resource |
| [aci_rest.commRsKeyRing](https://registry.terraform.io/providers/netascode/aci/latest/docs/resources/rest) | resource |
| [aci_rest.commSsh](https://registry.terraform.io/providers/netascode/aci/latest/docs/resources/rest) | resource |
| [aci_rest.commTelnet](https://registry.terraform.io/providers/netascode/aci/latest/docs/resources/rest) | resource |
<!-- END_TF_DOCS -->
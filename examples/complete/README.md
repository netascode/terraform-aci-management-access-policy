<!-- BEGIN_TF_DOCS -->
# Management Access Policy Example

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example will create resources. Resources can be destroyed with `terraform destroy`.

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
<!-- END_TF_DOCS -->